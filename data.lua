local M = {}
	M.maxLevels = 5
	M.settings = {}
	M.settings.currentLevel = 1
	M.settings.unlockedLevels = 5
	M.settings.soundOn = true
	M.settings.musicOn = true
	M.settings.levels = {} 
	 
	M.settings.levels[1] = {}
	M.settings.levels[1].title = "BEBÊ"
	M.settings.levels[1].stars = 3
	M.settings.levels[1].score = 3833
	M.settings.levels[1].background = "ui/baby/lvl_img.png"

	M.settings.levels[2] = {}
	M.settings.levels[2].title = "CRIANÇA"
	M.settings.levels[2].stars = 2
	M.settings.levels[2].score = 4394
	M.settings.levels[2].background = "ui/child/lvl_img.png"
	
	M.settings.levels[3] = {}
	M.settings.levels[3].title = "JOVEM"
	M.settings.levels[3].stars = 1
	M.settings.levels[3].score = 8384
	M.settings.levels[3].background = "ui/young/lvl_img.png"
	
	M.settings.levels[4] = {}
	M.settings.levels[4].title = "ADULTO"
	M.settings.levels[4].stars = 0
	M.settings.levels[4].score = 10294
	M.settings.levels[4].background = "ui/adult/lvl_img.png"

	M.settings.levels[5] = {}
	M.settings.levels[5].title = "IDOSO"
	M.settings.levels[5].stars = 0
	M.settings.levels[5].score = 10294
	M.settings.levels[5].background = "ui/old/lvl_img.png"

return M

-- https://www.youtube.com/watch?v=19NxtOMcQ1I&index=66&list=PLhE_IYaXVf9tCO31TomZo_j6y2iqdm7rz