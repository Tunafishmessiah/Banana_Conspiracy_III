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
    
    //esta variavel vai servir para mover tudo na cena conforme o que o jogador andar com cada ataque.
    //Como tudo tem de se mover a mesma velocidade, essa variavel é controlada aqui
    var Speed : CGFloat = 10
    
    var ScreenSize = CGPoint()
    
    
    func GameManager( level : Int, screenSize : CGPoint)
    {
        
        self.ScreenSize = screenSize
        // O chão vai andar a velocidade diferente para dar um efeito mais engraçado
        self.Background1.Background(self.Speed)
        self.Background2.Background(self.Speed)
        
        self.Background1.Node.position = CGPointMake(self.ScreenSize.x/2, self.ScreenSize.y/2)
        self.Background2.Node.position = CGPointMake((self.ScreenSize.x/2) + self.Background2.Node.size.width, self.ScreenSize.y/2 )
        
        //Quanto maior o nivel, mais inimigos vai dar spawn
        //Ou seja, o delay que o spawn tem é menor
        
    }
    func Update()
    {
        UpdateEnemies()
        //O chao, o background e o player nao precisam de update, pois sao estaticos
    
    }
    
    func UpdateEnemies()
    {
        //Ve o index de quais inimigos estao mortos
        var deletedEnemies = [Int]()
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
        
        //Dá update aos vivos
        for enemy in Enemies
        {
            enemy.Update()
        }
    }
    
    public func DoAttack(bAttackRight : Bool)
    {
        if (Enemies.count <= 0)
        {
            return
        }
        
        let Direction : CGFloat = (bAttackRight ? -1 : 1)
        var EnemiesInDir = [Enemy]()
        for Index in 0 ..< Enemies.count
        {
            if (Enemies[Index].Node.xScale  == Direction)
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
        
        MoveScene(bAttackRight, min(100, ClosestEnemyDistance))
        ClosestEnemy.DamageHP()
        ClosestEnemy.Die()
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
