local base = {}
    base.moneys = {}
    base.qtdMoney = 4

        base.moneys[1]={}
        base.moneys[1].value = "10"
        base.moneys[1].path = "ui/elements/ten.png"
        base.moneys[1].name = "money"

        base.moneys[2]={}
        base.moneys[2].value = "20"
        base.moneys[2].path = "ui/elements/twenty.png"
        base.moneys[2].name = "money"

        base.moneys[3]={}
        base.moneys[3].value = "50"
        base.moneys[3].path = "ui/elements/fifty.png"
        base.moneys[3].name = "money"

        base.moneys[4]={}
        base.moneys[4].value = "100"
        base.moneys[4].path = "ui/elements/oneHundred.png"
        base.moneys[4].name = "money"

    base.bills = {}
    base.qtdBill = 2

        base.bills[1]={}
        base.bills[1].value = "drug"
        base.bills[1].path = "ui/elements/drug.png"
        base.bills[1].name = "bill"

        base.bills[2]={}
        base.bills[2].value = "lotery"
        base.bills[2].path = "ui/elements/lotery.png"
        base.bills[2].name = "bill" 

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
return base