local base = {}
    base.levels = {}

    --------------------------------------
    --------------------------------------
    -------------- LEVELS ----------------
    --------------------------------------
    --------------------------------------

        --------------------------------------
        --- LEVEL 1 --------------------------
        --------------------------------------
        
        base.levels[1] = {}
            base.levels[1].background = "ui/telas/sky.png"
            base.levels[1].numBackgroundsNear = 7

            base.levels[1].collectibles = {}
            base.levels[1].numCollectibles = 2

                base.levels[1].collectibles[1]={}
                base.levels[1].collectibles[1].type = "health"
                base.levels[1].collectibles[1].path = "ui/collect/blast.png"

                base.levels[1].collectibles[2]={}
                base.levels[1].collectibles[2].type = "shoot"
                base.levels[1].collectibles[2].path = "ui/collect/bear.png"

            base.levels[1].obstacles = {}
            base.levels[1].numObstacles = 1
            
                base.levels[1].obstacles[1] = {}
                base.levels[1].obstacles[1].type = "health"
                base.levels[1].obstacles[1].path = "ui/collect/dicese.png"

        --------------------------------------
        --- LEVEL 2 --------------------------
        --------------------------------------
            
        base.levels[2] = {}
            base.levels[2].background = "ui/telas/sky.png"
            base.levels[2].numBackgroundsNear = 7
    
            base.levels[2].collectibles = {}
            base.levels[2].numCollectibles = 3
            
                base.levels[2].collectibles[1]={}
                base.levels[2].collectibles[1].type = "health"
                base.levels[2].collectibles[1].path = "ui/collect/pills.png"

                base.levels[2].collectibles[2]={}
                base.levels[2].collectibles[2].type = "happiness"
                base.levels[2].collectibles[2].path = "ui/collect/carts.png"

                base.levels[2].collectibles[3]={}
                base.levels[2].collectibles[3].type = "shoot"
                base.levels[2].collectibles[3].path = "ui/collect/ball.png"

            base.levels[2].obstacles = {}
            base.levels[2].numObstacles = 2
            
                base.levels[2].obstacles[1] = {}    
                base.levels[2].obstacles[1].type = "health"
                base.levels[2].obstacles[1].path = "ui/collect/dicese.png"

                base.levels[2].obstacles[2] = {}    
                base.levels[2].obstacles[2].type = "happiness"
                base.levels[2].obstacles[2].path = "ui/collect/badvibe.png"

        --------------------------------------
        --- LEVEL 3 --------------------------
        --------------------------------------
            
        base.levels[3] = {}
            base.levels[3].background = "ui/telas/sky.png"
            base.levels[3].numBackgroundsNear = 6

            base.levels[3].collectibles = {}
            base.levels[3].numCollectibles = 5        

                base.levels[3].collectibles[1]={}
                base.levels[3].collectibles[1].type = "health"
                base.levels[3].collectibles[1].path = "ui/collect/pills.png"

                base.levels[3].collectibles[2]={}
                base.levels[3].collectibles[2].type = "money"
                base.levels[3].collectibles[2].path = "ui/collect/money.png"

                base.levels[3].collectibles[3]={}
                base.levels[3].collectibles[3].type = "happiness"
                base.levels[3].collectibles[3].path = "ui/collect/carts.png"

                base.levels[3].collectibles[4]={}
                base.levels[3].collectibles[4].type = "shoot"
                base.levels[3].collectibles[4].path = "ui/collect/phone.png"

                base.levels[3].collectibles[5]={}
                base.levels[3].collectibles[5].type = "love"
                base.levels[3].collectibles[5].path = "ui/collect/star.png"

            base.levels[3].obstacles = {}
            base.levels[3].numObstacles = 3
            
                base.levels[3].obstacles[1] = {}    
                base.levels[3].obstacles[1].type = "health"
                base.levels[3].obstacles[1].path = "ui/collect/dicese.png"

                base.levels[3].obstacles[2] = {}    
                base.levels[3].obstacles[2].type = "money"
                base.levels[3].obstacles[2].path = "ui/collect/debt.png"

                base.levels[3].obstacles[3] = {}    
                base.levels[3].obstacles[3].type = "happiness"
                base.levels[3].obstacles[3].path = "ui/collect/badvibe.png"

    --------------------------------------
    --------------------------------------
    ----------- ACHIEVEMENTS -------------
    --------------------------------------
    --------------------------------------

    base.numAchievements = 7
    base.achievements = {}

        base.achievements[1] = {}
        base.achievements[1].title = "Saúde de Ferro"    
        base.achievements[1].description = "lorem Ipslum lallalalala"

        base.achievements[2] = {}
        base.achievements[2].title = "CDF"    
        base.achievements[2].description = "lorem Ipslum lallalalala"

        base.achievements[3] = {}
        base.achievements[3].title = "Rebelde"    
        base.achievements[3].description = "lorem Ipslum lallalalala"

        base.achievements[4] = {}
        base.achievements[4].title = "Apaixonado"    
        base.achievements[4].description = "lorem Ipslum lallalalala"

        base.achievements[5] = {}
        base.achievements[5].title = "Milionário"    
        base.achievements[5].description = "lorem Ipslum lallalalala"

        base.achievements[6] = {}
        base.achievements[6].title = "Recém-Casado"    
        base.achievements[6].description = "lorem Ipslum lallalalala"

        base.achievements[7] = {}
        base.achievements[7].title = "Aposentado"    
        base.achievements[7].description = "lorem Ipslum lallalalala"
    
    --------------------------------------
    --------------------------------------
    ------------- SETTINGS ---------------
    --------------------------------------
    --------------------------------------

return base