local M = {}
	M.maxLevels = 3
	M.settings = {}
	M.settings.currentLevel = 1
	M.settings.unlockedLevels = 3
	M.settings.levels = {} 
	 
	M.settings.levels[1] = {}
	M.settings.levels[1].title = "Lower Class"
	M.settings.levels[1].stars = 0
	M.settings.levels[1].score = 500
	M.settings.levels[1].background = "images/screens/imgLvl1.png"

	M.settings.levels[2] = {}
	M.settings.levels[2].title = "Middle Class"
	M.settings.levels[2].stars = 0
	M.settings.levels[2].score = 1000
	M.settings.levels[2].background = "images/screens/imgLvl2.png"
	
	M.settings.levels[3] = {}
	M.settings.levels[3].title = "Upper Class"
	M.settings.levels[3].stars = 0
	M.settings.levels[3].score = 2500
	M.settings.levels[3].background = "images/screens/imgLvl3.png"
	
return M

-- https://www.youtube.com/watch?v=19NxtOMcQ1I&index=66&list=PLhE_IYaXVf9tCO31TomZo_j6y2iqdm7rz