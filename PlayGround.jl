
"""
Providing a Playground 

    Play with this Parameters to get a better understanding
"""
MUTATIONRATE = [25,250,500]            # no more than 3 pls
STARTPOPULATION = [1.,1.,1.,1.]        # here you can edit which Starting Conditions for each Stragie values between 1 - 25 will be sensefull, popsize == 4 
A_PAYOFF = [4.0 0.0; 5.0 1.0]          # as u want 
T = 100                # Generations
NGENERATIONS = T*100   # resolution
#Strategies
STRATEGIES_TFT_VS_DF =  [[0.021, 0.021], [0.99, 0.01], [0.01, 0.01], [0.02, 0.01]]
STRATEGIES_TFT_VS_AC =  [[0.99, 0.021], [0.99, 0.99], [0.91, 0.91], [0.02, 0.99]]
STRATEGIES_COEX =  [[0.01, 0.01], [0.99, 0.01], [0.99, 0.99], [0.5, 0.01]]

STRATEGIES_EXTREM_MIX_UP = [[0.01, 0.01], [0.99, 0.01], [0.01, 0.99], [0.99, 0.09]]
STRATEGIES_TIT_FOR_TAT = [[0.9, 0.01], [0.9, 0.002], [0.8, 0.001], [0.85, 0.01]]
STRATEGIES_GRIMM = [[0.4, 0.01], [0.5, 0.01], [0.5, 0.01], [0.45, 0.001]]

STRATEGIES_RANDOM = [[rand(0.2:0.001:0.8), rand(0.2:0.001:0.8)],
                     [rand(0.2:0.001:0.8), rand(0.2:0.001:0.8)], 
                     [rand(0.2:0.001:0.8), rand(0.2:0.001:0.8)], 
                     [rand(0.2:0.001:0.8), rand(0.2:0.001:0.8)]] 

STRATEGIES_MIX_UP = [[0.31, 0.31], [0.66, 0.31], [0.61, 0.69], [0.69, 0.31]]
STRATEGIES_ALL_COOPERATE = [[0.9, 0.92], [0.9, 0.8], [0.8, 0.9], [0.85, 0.95]]
STRATEGIES_ALL_DEFECT = [[0.01, 0.03], [0.12, 0.2], [0.5, 0.3], [0.15, 0.1]]
#
TIME_DISPLAY_LAYOUT = 60

EXPLANATION = "Assumptions: Mutation is randomly distributed and therefore happens most frequently in the densest population."
RESEARCH_QUESTION ="""
How does a system of strategies with a representative population behave with mutation and selection,
when the strategy of the densest population is chosen as the origin of mutation and 
the strategy of the least represented population is replaced?"""

WHATTODO ="""
Please resize the window of GLMakie so that you can see the three diagrams their legend and the terminal.
You will see the final behaviour of our population and the results for displayed testcase in the terminal.
You will have 60s for each Testcase.
For a better understanding I would recommend to visit the Playgroud file here you can play around with the values of the code.
Additional in the folder Outputs there will be every diagramm as singel or as layout saved, you can use this for a fast check of our results.
"""


RES_ALL_DEFECT = "In a world where everyone is defecting the biggest defecter wins"
RES_TIT_FOR_TAT = "In a world where everyone is copying his predecessor the world turns to be more cooperative "
RES_ALL_COOPERATE = "In a world where everyone is cooperating the world turns into defecting"
RES_GRIMM ="In a world where everyone is a grimm the world turns into defecting with small pobability of cooperating "
RES_EXTREM_MIXED_UP = "In a world where the strategies are extremly mixed up everything turns into a Tft but there is the probability of a coexistenz of AC & TFT & ADF "
RES_RANDOM = "In a world with semi randomness the population turn into a strong defecting with more pobability on a cooperating population."
RES_MIXED_UP ="In a mixed world the population will turn into a Tit for Tat with stronger forgivness rate or into a defecting world"

RES_TFT_VS_ADF ="Tft dominates All defect"
RES_TFT_VS_AC ="Tit for Tat leads to an periodic system between cooperating and defecting"
RES_COEX = "Here you can see the coexistenz of DF, C, Tft so that means Altruism can help for having varieties of strategies"