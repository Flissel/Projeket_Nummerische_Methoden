
"""
Providing a Playground 

    Play with this Parameters to get a better understanding
"""


const MUTATIONRATE = [2,25,250,500,10000] # not more than 5 pls
const STARTPOPULATION = [1.,1.,1.,1.]     # here you can edit which Starting Conditions for each Stragie values between 1 - 25 will be sensefull 
const A_PAYOFF = [4.0 0.0; 5.0 1.0]       # as u want 

const NGENERATIONS = 100000 # resolution
const T = 10000              # Generations

const STRAGIES_EXTREM_MIX_UP = [[0.01, 0.01], [0.99, 0.01], [0.01, 0.99], [0.99, 0.01]]
const STRAGIES_TIT_FOR_TAT = [[0.9, 0.01], [0.9, 0.002], [0.8, 0.001], [0.85, 0.2]]
const STRAGIES_GRIMM = [[0.4, 0.01], [0.5, 0.01], [0.5, 0.01], [0.45, 0.001]]
const STRAGIES_RANDOM = [[rand(0.2:0.2:0.8), rand(0.2:0.2:0.8)],
                         [rand(0.2:0.2:0.8), rand(0.2:0.2:0.8)], 
                         [rand(0.2:0.2:0.8), rand(0.2:0.2:0.8)], 
                         [rand(0.2:0.2:0.8), rand(0.2:0.2:0.8)]] 
const STRAGIES_MIX_UP = [[0.31, 0.31], [0.66, 0.31], [0.61, 0.69], [0.69, 0.31]]
const STRAGIES_ALL_COOPERATE = [[0.9, 0.92], [0.9, 0.8], [0.8, 0.9], [0.85, 0.95]]
const STRAGIES_ALL_DEFECT = [[0.01, 0.03], [0.12, 0.2], [0.5, 0.3], [0.15, 0.1]]
