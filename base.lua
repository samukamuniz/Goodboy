local base = {}
    base.levels = {}       
        base.levels[1] = {}
            base.levels[1].background = "ui/background/sky.png"
            base.levels[1].numBackgroundsNear = 2
            base.levels[1].backgroundNear = {}

                base.levels[1].backgroundNear[1] = {}
                base.levels[1].backgroundNear[1].path = "ui/background/city1.png"
                base.levels[1].backgroundNear[1].y = 210
                
                base.levels[1].backgroundNear[2] = {}
                base.levels[1].backgroundNear[2].path = "ui/background/city2.png"
                base.levels[1].backgroundNear[2].y = 210

                base.levels[1].backgroundNear[3] = {}
                base.levels[1].backgroundNear[3].path = "ui/background/city2.png"
                base.levels[1].backgroundNear[3].y = 100
                
            base.levels[1].collectibles = {}
            base.levels[1].numCollectibles = 4

                base.levels[1].collectibles[1]={}
                base.levels[1].collectibles[1].type = "10"
                base.levels[1].collectibles[1].path = "ui/elements/ten.png"

                base.levels[1].collectibles[2]={}
                base.levels[1].collectibles[2].type = "20"
                base.levels[1].collectibles[2].path = "ui/elements/twenty.png"

                base.levels[1].collectibles[3]={}
                base.levels[1].collectibles[3].type = "50"
                base.levels[1].collectibles[3].path = "ui/elements/fifty.png"

                base.levels[1].collectibles[4]={}
                base.levels[1].collectibles[4].type = "100"
                base.levels[1].collectibles[4].path = "ui/elements/oneHundred.png"


            base.levels[1].obstacles = {}
            base.levels[1].numObstacles = 2
            
                base.levels[1].obstacles[1] = {}
                base.levels[1].obstacles[1].type = "drug"
                base.levels[1].obstacles[1].path = "ui/elements/drug.png"

                base.levels[1].obstacles[2] = {}
                base.levels[1].obstacles[2].type = "lotery"
                base.levels[1].obstacles[2].path = "ui/elements/lotery.png"

return base