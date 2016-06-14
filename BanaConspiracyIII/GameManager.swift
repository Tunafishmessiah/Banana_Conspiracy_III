// Esta classe deve conter os inimigos e coisas como o background e o chão
// Para ser mais facil de mover todos os objectos dentro do mapa.



import Foundation
import SpriteKit
class GameManager {
    
    //Contem todos os inimigos da cena para uma gestão mais facil
    var Enemies = [Enemy]()
    
    var Background1 = Background()
    var Background2 = Background()
    
    var Floor1 = Floor()
    var Floor2 = Floor()
    
    public var Nerd = Player()
    
    //esta variavel vai servir para mover tudo na cena conforme o que o jogador andar com cada ataque.
    //Como tudo tem de se mover a mesma velocidade, essa variavel é controlada aqui
    var Speed : CGFloat = 10
    
    var ScreenSize = CGPoint()
    
    var EnemyTimerStarter = 30 //frames para ter um novo inimigo
    var EnemyTimer = 0
    var Level = Int()
    
    //var gameScene  = GameScene()
    
    func GameManager( level : Int, screenSize : CGPoint, _ childAdder : GameScene)
    {
        self.Level = level
        //self.gameScene = childAdder
        
        self.ScreenSize = screenSize
        // O chão vai andar a velocidade diferente para dar um efeito mais engraçado
        self.Background1.Background(self.Speed)
        self.Background2.Background(self.Speed)
        
        self.Background1.Node.position = CGPointMake(self.ScreenSize.x/2, self.ScreenSize.y/2)
        self.Background2.Node.position = CGPointMake((self.ScreenSize.x/2) + self.Background2.Node.size.width, self.ScreenSize.y/2 )
        
        self.Floor1.Node.position = CGPointMake(self.ScreenSize.x/2, self.ScreenSize.y/2)
        self.Floor2.Node.position = CGPointMake((self.ScreenSize.x/2) + self.Floor2.Node.size.width, self.ScreenSize.y/2 )
        
        
        Nerd.Player(screenSize)
        childAdder.addChild(Nerd.Node)
        
        //Quanto maior o nivel, mais inimigos vai dar spawn
        //Ou seja, o delay que o spawn tem é menor
        /*childAdder.addChild(Background1.Node)
        childAdder.addChild(Background2.Node)
        childAdder.addChild(Floor1.Node)
        childAdder.addChild(Floor2.Node)*/
    }
    func Update(childAdder : GameScene)
    {
        UpdateEnemies(childAdder)
        Nerd.Update()
        //O chao e o background nao precisam de update, pois sao estaticos
    
    }
    
    func UpdateEnemies(childAdder : GameScene)
    {
        if(abs(EnemyTimer * (1/self.Level)) <= 0 )
        {
            let newEnemy = Enemy()
            newEnemy.Enemy(ScreenSize)
            let SpawnX : CGFloat = (newEnemy.Node.xScale < 0 ? 0 : self.ScreenSize.x)
            newEnemy.Node.position = CGPoint(x: SpawnX, y: self.ScreenSize.y/10 + (2 * newEnemy.Node.size.height)/3)
            childAdder.addChild(newEnemy.Node)
            Enemies.append(newEnemy)
            
            EnemyTimer = EnemyTimerStarter
        }
        else
        {
            EnemyTimer--
        }
        
        
        //Ve o index de quais inimigos estao mortos
        var deletedEnemies = [Int]()
        if(deletedEnemies.count > 0)
        {
            for aux in 0 ... Enemies.count-1
            {
                if (Enemies[aux].HP <= 0)
                {
                    deletedEnemies.append(aux)
                }
            }
        
            //Elimina-os da cena
            for deleteIndex in deletedEnemies
            {
                Enemies.removeAtIndex(deleteIndex)
            }
        }
        //Dá update aos vivos
        for enemy in Enemies
        {
            enemy.Update(Nerd.Node.position)
        }
    }
    
    public func DoAttack(bAttackRight : Bool)
    {
        MinionsAttack(bAttackRight)
        Nerd.Attack(bAttackRight)
        
    }
    
    func MinionsAttack(bAttackRight : Bool)
    {
        if (Enemies.count <= 0)
        {
            return
        }
        
        let Direction : CGFloat = (bAttackRight ? 1 : -1)
        var EnemiesInDir = [Enemy]()
        for Index in 0 ..< Enemies.count
        {
            if (Enemies[Index].Node.xScale  == Direction && Enemies[Index].HP > 0)
            {
                EnemiesInDir.append(Enemies[Index])
            }
        }
        
        if (EnemiesInDir.count <= 0)
        {
            return
        }
        
        var ClosestEnemy : Enemy = EnemiesInDir[0]
        var ClosestEnemyDistance : CGFloat = abs(EnemiesInDir[0].Node.position.x - self.ScreenSize.x / 2)
        for Index in 0 ..< EnemiesInDir.count
        {
            let DistanceToNerd : CGFloat = abs(EnemiesInDir[Index].Node.position.x - self.ScreenSize.x / 2)
            if (DistanceToNerd < ClosestEnemyDistance)
            {
                ClosestEnemy = EnemiesInDir[Index]
                ClosestEnemyDistance = DistanceToNerd
            }
        }
        
        MoveScene(bAttackRight, min(CGFloat(Nerd.AttackRange), ClosestEnemyDistance - Nerd.Node.size.width / 2))
        if (ClosestEnemyDistance <= CGFloat(Nerd.AttackRange))
        {
            ClosestEnemy.DamageHP()
            ClosestEnemy.Die()
        }
    }
    
    func MoveScene(bAttackRight : Bool, _ DistanceToMove : CGFloat)
    {
        if (Enemies.count > 0)
        {
            for Index in 0 ..< Enemies.count
            {
                Enemies[Index].moveEnemies(bAttackRight, distanceToMove: DistanceToMove)
            }
        }
        
        Floor1.MoveFloors(bAttackRight, DistanceToMove)
        Floor2.MoveFloors(bAttackRight, DistanceToMove)
        
        Background1.MoveBackground(bAttackRight, DistanceToMove)
        Background2.MoveBackground(bAttackRight, DistanceToMove)
    }
    
}
