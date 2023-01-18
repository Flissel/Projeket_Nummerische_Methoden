
"""
Providing a Playground 

    Play with this Parameters to get a better understanding
"""


const MUTATIONRATE = [25,250,500] # not more than 5 pls
const STARTPOPULATION = [1.,1.,1.,1.]     # here you can edit which Starting Conditions for each Stragie values between 1 - 25 will be sensefull 
const A_PAYOFF = [4.0 0.0; 5.0 1.0]       # as u want 

const NGENERATIONS = 100000  # resolution
const T = 1000              # Generations

const STRATEGIES_TFT_VS_DF=  [[0.021, 0.021], [0.99, 0.01], [0.01, 0.01], [0.02, 0.01]]
const STRATEGIES_TFT_VS_AC=  [[0.99, 0.021], [0.99, 0.99], [0.91, 0.91], [0.02, 0.99]]
const STRATEGIES_COEX =  [[0.01, 0.01], [0.99, 0.01], [0.99, 0.99], [0.5, 0.01]]

const STRATEGIES_EXTREM_MIX_UP = [[0.01, 0.01], [0.99, 0.01], [0.01, 0.99], [0.99, 0.09]]
const STRATEGIES_TIT_FOR_TAT = [[0.9, 0.01], [0.9, 0.002], [0.8, 0.001], [0.85, 0.01]]
const STRATEGIES_GRIMM = [[0.4, 0.01], [0.5, 0.01], [0.5, 0.01], [0.45, 0.001]]
const STRATEGIES_RANDOM = [[rand(0.2:0.8), rand(0.2:0.8)],
                           [rand(0.2:0.8), rand(0.2:0.8)], 
                           [rand(0.2:0.8), rand(0.2:0.8)], 
                           [rand(0.2:0.8), rand(0.2:0.8)]] 
const STRATEGIES_MIX_UP = [[0.31, 0.31], [0.66, 0.31], [0.61, 0.69], [0.69, 0.31]]
const STRATEGIES_ALL_COOPERATE = [[0.9, 0.92], [0.9, 0.8], [0.8, 0.9], [0.85, 0.95]]
const STRATEGIES_ALL_DEFECT = [[0.01, 0.03], [0.12, 0.2], [0.5, 0.3], [0.15, 0.1]]

const TIME_DISPLAY_LAYOUT = 120

const RES_ALL_DEFECT = "In a world where everyone is Defecting the biggest Defecter wins"
const RES_TIT_FOR_TAT = "In a world where everyone is copying his Predecessor the World turns to be more cooperative "
const RES_ALL_COOPERATE = "In a world where everyone is cooperating the world turns into defecting"
const RES_GRIMM ="In a world where everyone is a Grimm the world turns into defecting with small pobability of cooperating "
const RES_EXTREM_MIXED_UP = "In a world where the Stragies are extremly mixed up everything turns into a Tit for Tat but there is the probability of a coexistenz of AC & TFT & ADF "
const RES_RANDOM = "In a world with semi randomness the population turn into a strong defecting with more pobability on a cooperating population."
const RES_MIXED_UP ="In a mixed world the population will turn into a Tit for Tat with stronger forgivness rate or into a defecting world   "
const RES_COEX = "Here you can see the coexistenz of DF, AC, Tft"
const RES_TFT_VS_ADF ="Tit for Tat dominates All defect"
const RES_TFT_VS_AC ="Tit for Tat leads to an periodic system between cooperating and defecting"
