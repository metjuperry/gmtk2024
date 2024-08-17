extends Node

signal resourcesUpdated(newMoney: float, moneyChange: float, newProducts: float, productsChange: float)
signal peopleUpdated(newDemand: float,demandChange:float, newSatisfaction: float, satisfactionChange: float)

@export_group("Raw resources")
@export var workers : int = 0;
@export var money : float = 0;
@export var availableProducts : float = 0;
@export var couriers : int = 0;

@export_group("Weights")
@export var workersProductivity : float = 1.0;
@export var courierEffectivenes : float = 1.0;


@export_group("Money")
@export var basePricePerProduct: float = 1;
@export_range(-20.0, 20.0) var priceModified : float = 0;
@export var workerSalary : int = 0;
@export var courierSalary : int = 0;

@export_group("People")
@export var demand : int = 0;
@export_range(-100.0, 100.0) var satisfaction: float = 50.0;
@export var demandMetBonus: float = 0.0;

@export_group("Area")
@export var satisfactionConstant: float = 1.0;
@export var demandConstant: float = 1.0;

func recalculate_products_and_money() -> void:
		# Each courier working at their effectivenes, rounded up.
	var courierCapacity = ceil(couriers * courierEffectivenes);
	# The lowest nmumber of these is the one we actually sold
	var actuallySoldProducts = min(availableProducts, courierCapacity, demand)
	
	var oldMoney = money;
	var oldProducts = availableProducts;
	
	# Sold products times money + (or minus) modifier
	money += actuallySoldProducts * (basePricePerProduct + (basePricePerProduct/100.0 * priceModified ))
	
	# Remove stock, pay salary
	availableProducts -= actuallySoldProducts;
	money -= (workers * workerSalary) + (couriers * courierSalary)
	
	# get new stock
	availableProducts += workersProductivity;
	
	resourcesUpdated.emit(money,money - oldMoney, availableProducts, availableProducts - oldProducts)
	

func recalcualte_satisfaction_and_demand() -> void:
			# Each courier working at their effectivenes, rounded up.
	var courierCapacity = ceil(couriers * courierEffectivenes);
	# The lowest nmumber of these is the one we actually sold
	var actuallySoldProducts = min(availableProducts, courierCapacity, demand)
	
	var oldDemand = demand;
	var oldSatisfaction = satisfaction;
	
	if(actuallySoldProducts >= demand):
		satisfaction += satisfactionConstant + demandMetBonus;
	else:
		satisfaction -= satisfactionConstant * (actuallySoldProducts/demand);
		
	if(satisfaction <= 0):
		# game over
		return
	demand = demandConstant + (demandConstant * (satisfaction/20)) + (demandConstant - (demandConstant/100.0 * priceModified ))

	peopleUpdated.emit(demand, oldDemand - demand, satisfaction, oldSatisfaction - satisfaction)

func _on_orloj_cycle_complete() -> void:
	recalcualte_satisfaction_and_demand();
	recalculate_products_and_money();
	
	return
