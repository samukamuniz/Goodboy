local base = {}
    base.moneys = {}
    base.qtdMoney = 5

        base.moneys[1]={}
        base.moneys[1].name = "10"
        base.moneys[1].path = "ui/elements/ten.png"
        base.moneys[1].value = 10
        base.moneys[1].type = "money"

        base.moneys[2]={}
        base.moneys[2].name = "20"
        base.moneys[2].path = "ui/elements/twenty.png"
        base.moneys[2].value = 20
        base.moneys[2].type = "money"

        base.moneys[3]={}
        base.moneys[3].name = "50"
        base.moneys[3].path = "ui/elements/fifty.png"
        base.moneys[3].value = 50
        base.moneys[3].type = "money"

        base.moneys[4]={}
        base.moneys[4].name = "100"
        base.moneys[4].path = "ui/elements/oneHundred.png"
        base.moneys[4].value = 100
        base.moneys[4].type = "money"

        base.moneys[5]={}
        base.moneys[5].name = "bonus"
        base.moneys[5].path = "ui/elements/moneyBag.png"
        base.moneys[5].value = 250
        base.moneys[5].type = "money"

    base.bills = {}
    base.qtdBill = 3

        base.bills[1]={}
        base.bills[1].name = "beer"
        base.bills[1].path = "ui/elements/beer.png"
        base.bills[1].value = 20
        base.bills[1].type = "bill"

        base.bills[2]={}
        base.bills[2].name = "drug"
        base.bills[2].path = "ui/elements/drug.png"
        base.bills[2].value = 50
        base.bills[2].type = "bill"

        base.bills[3]={}
        base.bills[3].name = "lotery"
        base.bills[3].path = "ui/elements/lotery.png"
        base.bills[3].value = 100
        base.bills[3].type = "bill" 

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