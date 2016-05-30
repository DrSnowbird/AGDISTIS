from agdistispy.agdistis import Agdistis

ag = Agdistis()
entities=ag.disambiguate("<entity>Austria</entity>")
print(entities)
