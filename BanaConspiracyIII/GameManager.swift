// Esta classe deve conter os inimigos e coisas como o background e o chão
// Para ser mais facil de mover todos os objectos dentro do mapa.



import Foundation
import SpriteKit
import AVFoundation

class GameManager {
    
    //Contem todos os inimigos da cena para uma gestão mais facil
    var Enemies = [Enemy]()
    
    var Background0 = Background()
    var Background1 = Background()
    var Background2 = Background()
    
    var Floor0 = Floor()
    var Floor1 = Floor()
    var Floor2 = Floor()
    
    public var Nerd = Player()
    
    //esta variavel vai servir para mover tudo na cena conforme o que o jogador andar com cada ataque.
    //Como tudo tem de se mover a mesma velocidade, essa variavel é controlada aqui
    var Speed : CGFloat = 100
    
    var ScreenSize = CGPoint()
    
    var EnemyTimerStarter = 100 //frames para ter um novo inimigo
    var EnemyTimer = 0
    var Level = Int()
    
    public var Points = 0
    
    var SceneChange = false
    
    var LabelLife = SKLabelNode()
    var LabelPontos = SKLabelNode()
    
    var backgroundMusicPlayer = AVAudioPlayer()
    var playerHit = AVAudioPlayer()
    var enemyHit = AVAudioPlayer()
    
    //var gameScene  = GameScene()
    
    func GameManager( level : Int, screenSize : CGPoint, _ childAdder : GameScene)
    {
        self.Level = level
        //self.gameScene = childAdder
        
        self.ScreenSize = screenSize
        // O chão vai andar a velocidade diferente para dar um efeito mais engraçado
        self.Background0.Background(self.Speed)
        self.Background1.Background(self.Speed)
        self.Background2.Background(self.Speed)
        
        self.Background0.Node.position = CGPointMake(self.ScreenSize.x/2, self.ScreenSize.y/2)
        self.Background1.Node.position = CGPointMake((self.ScreenSize.x/2) + self.Background1.Node.size.width, self.ScreenSize.y/2 )
        self.Background2.Node.position = CGPointMake((self.ScreenSize.x/2) + self.Background2.Node.size.width, self.ScreenSize.y/2 )
    
        childAdder.addChild(self.Background0.Node)
        childAdder.addChild(self.Background1.Node)
        childAdder.addChild(self.Background2.Node)
        
        Nerd.Player(screenSize)
        childAdder.addChild(Nerd.Node)
        
        
        self.Floor0.Floor()
        self.Floor0.Node.position = CGPointMake(self.ScreenSize.x/2,self.Nerd.Node.position.y - self.Nerd.Node.size.height/2)
        childAdder.addChild(self.Floor0.Node)
        
        self.Floor1.Floor()
        self.Floor1.Node.position = CGPointMake(self.ScreenSize.x + self.ScreenSize.x/2, self.Nerd.Node.position.y - self.Nerd.Node.size.height/2)
        childAdder.addChild(self.Floor1.Node)
        
        self.Floor2.Floor()
        self.Floor2.Node.position = CGPointMake(self.ScreenSize.x + 2 + self.ScreenSize.x/2, self.Nerd.Node.position.y - self.Nerd.Node.size.height/2)
        childAdder.addChild(self.Floor2.Node)
        
        
        LabelLife = SKLabelNode(fontNamed: "Chalkduster")
        LabelLife.fontColor = SKColor.redColor()
        LabelLife.text = "Life >> \(Nerd.HP)"
        LabelLife.fontSize = 25
        LabelLife.zPosition = 4
        LabelLife.position = CGPoint(x: ScreenSize.x/2 - 375, y: screenSize.y - 200)
        childAdder.addChild(LabelLife)
        
        LabelPontos = SKLabelNode(fontNamed: "Chalkduster")
        LabelPontos.fontColor = SKColor.greenColor()
        LabelPontos.text = "Points >> \(self.Points)"
        LabelPontos.fontSize = 30
        LabelPontos.position = CGPoint(x: screenSize.x - 275  , y: screenSize.y - 200)
        LabelPontos.zPosition = 4
        childAdder.addChild(LabelPontos)
        
        SoundsUp("Guile Theme (SNES)[Game].mp3")
        
        
    }
    
    func Update(childAdder : GameScene)
    {
        UpdateEnemies(childAdder)
        
        var damage = false
        for enemy in self.Enemies
        {
            if(enemy.attackTimer == 30 && Nerd.HP > 0)
            {
                damage = true
            }
        }
        
        if(damage)
        {
            enemyHitMake()
            Nerd.DamageHP()
            if(self.Nerd.HP == 0)
            {
                self.Nerd.Die()
            }
        }

        if(Nerd.HP > 0)
        {
            self.Nerd.Update()
        }
        
        
        if(Nerd.IsDead)
        {
            SceneChange = true
        }
        
        LabelLife.text = "Life >> \(Nerd.HP)"
        LabelPontos.text = "Points >> \(self.Points)"
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
        if(Nerd.HP > 0)
        {
            MinionsAttack(bAttackRight)
            Nerd.Attack(bAttackRight)
        }
        
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
        
        var ClosestEnemyDistance : CGFloat = CGFloat(self.Nerd.AttackRange)
        
        if(EnemiesInDir.count != 0)
        {
        
        var ClosestEnemy : Enemy = EnemiesInDir[0]
        ClosestEnemyDistance = abs(EnemiesInDir[0].Node.position.x - self.ScreenSize.x / 2)
            
        for Index in 0 ..< EnemiesInDir.count
        {
            let DistanceToNerd : CGFloat = abs(EnemiesInDir[Index].Node.position.x - self.ScreenSize.x / 2)
            if (DistanceToNerd < ClosestEnemyDistance)
            {
                ClosestEnemy = EnemiesInDir[Index]
                ClosestEnemyDistance = DistanceToNerd
            }
        }
        
        if (ClosestEnemyDistance <= CGFloat(Nerd.AttackRange))
        {
            playerHitMake()
            ClosestEnemy.DamageHP()
            ClosestEnemy.Die()
            Points++
        }
        }
        
        MoveScene(bAttackRight, min(CGFloat(Nerd.AttackRange), ClosestEnemyDistance - Nerd.Node.size.width / 2))
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
        
        MoveFloors(bAttackRight, DistanceToMove)
        
        MoveBackgrounds(bAttackRight, DistanceToMove)

    }
    
    func MoveFloors(bAttackRight : Bool, _ DistanceToMove : CGFloat)
    {
        Floor0.MoveFloors(bAttackRight, DistanceToMove)
        Floor1.MoveFloors(bAttackRight, DistanceToMove)
        Floor2.MoveFloors(bAttackRight, DistanceToMove)
        
        var aux = [CGFloat]()
        
        aux.append(abs(Floor0.Node.position.x - self.Nerd.Node.position.x))
        aux.append(abs(Floor1.Node.position.x - self.Nerd.Node.position.x))
        aux.append(abs(Floor2.Node.position.x - self.Nerd.Node.position.x))
        
        
        if(aux[0] <= aux[1] && aux[0] <= aux[2])
        {
            self.Floor1.Node.position.x = self.Floor0.Node.position.x + self.Floor0.Node.size.width - 1
            self.Floor2.Node.position.x = self.Floor0.Node.position.x - self.Floor0.Node.size.width  + 1
        }
        else if(aux[1] <= aux[0] && aux[1] <= aux[2])
        {
            
            self.Floor0.Node.position.x = self.Floor1.Node.position.x + self.Floor1.Node.size.width  - 1
            self.Floor2.Node.position.x = self.Floor1.Node.position.x - self.Floor1.Node.size.width + 1
        }
        else if (aux[2] <= aux[1] && aux[2] <= aux[1])
        {
            
            self.Floor0.Node.position.x = self.Floor2.Node.position.x + self.Floor2.Node.size.width - 1
            self.Floor1.Node.position.x = self.Floor2.Node.position.x - self.Floor2.Node.size.width + 1
        }
        
    }
    func MoveBackgrounds(bAttackRight : Bool, _ DistanceToMove : CGFloat)
    {
        self.Background0.MoveBackground(bAttackRight, DistanceToMove)
        self.Background1.MoveBackground(bAttackRight, DistanceToMove)
        self.Background2.MoveBackground(bAttackRight, DistanceToMove)
        
        var aux = [CGFloat]()
        
        aux.append(abs(self.Background0.Node.position.x - self.Nerd.Node.position.x))
        aux.append(abs(self.Background1.Node.position.x - self.Nerd.Node.position.x))
        aux.append(abs(self.Background2.Node.position.x - self.Nerd.Node.position.x))
        
        
        if(aux[0] <= aux[1] && aux[0] <= aux[2])
        {
            self.Background1.Node.position.x = self.Background0.Node.position.x + self.Background0.Node.size.width - 1
            self.Background2.Node.position.x = self.Background0.Node.position.x - self.Background0.Node.size.width  + 1
        }
        else if(aux[1] <= aux[0] && aux[1] <= aux[2])
        {
            
            self.Background0.Node.position.x = self.Background1.Node.position.x + self.Background1.Node.size.width  - 1
            self.Background2.Node.position.x = self.Background1.Node.position.x - self.Background1.Node.size.width + 1
        }
        else if (aux[2] <= aux[1] && aux[2] <= aux[1])
        {
            
            self.Background0.Node.position.x = self.Background2.Node.position.x + self.Background2.Node.size.width - 1
            self.Background1.Node.position.x = self.Background2.Node.position.x - self.Background2.Node.size.width + 1
        }
        
    }
    
    func Delete(childAdder : GameScene)
    {
        backgroundMusicPlayer.stop()
        childAdder.removeAllChildren()
    }
    
    func SoundsUp(filename : String)
    {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        guard let newURL = url else {
            return
        }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func playerHitMake()
    {
        let url = NSBundle.mainBundle().URLForResource("Hit3.mp3", withExtension: nil)
        guard let newURL = url else {
            return
        }
        do {
            playerHit = try AVAudioPlayer(contentsOfURL: newURL)
            playerHit.numberOfLoops = 0
            playerHit.prepareToPlay()
            playerHit.play()
        } catch let error as NSError {
            print(error.description)
        }
        
    }
    func enemyHitMake()
    {
        let url = NSBundle.mainBundle().URLForResource("Hit1.mp3", withExtension: nil)
        guard let newURL = url else {
            return
        }
        do {
            enemyHit = try AVAudioPlayer(contentsOfURL: newURL)
            enemyHit.numberOfLoops = 0
            enemyHit.prepareToPlay()
            enemyHit.play()
        } catch let error as NSError {
            print(error.description)
        }
        
    }
    
}
