extends Node

signal resourcesUpdated(newMoney: float, moneyChange: float, newProducts: float, productsChange: float, workerProductivity: float, couriers: int)
signal peopleUpdated(newDemand: float,demandChange:float, newSatisfaction: float, satisfactionChange: float)

signal moveNextPhase()
signal gameOver()

var secondPhase = false;

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

func _ready() -> void:
	resourcesUpdated.emit(money,0, availableProducts, 0, workersProductivity)
	peopleUpdated.emit(demand,0, satisfaction,0)

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
	
	resourcesUpdated.emit(money,money - oldMoney, availableProducts, availableProducts - oldProducts, workersProductivity, couriers)

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
		satisfaction +=  -satisfactionConstant * (actuallySoldProducts/demand);
		
	if(satisfaction <= 0):
		gameOver.emit()
		return
	
	if(satisfaction >= 95 && !secondPhase):
		secondPhase = true;
		moveNextPhase.emit();
	
	demand = demandConstant + (demandConstant * (satisfaction/20)) + (demandConstant - (demandConstant/100.0 * priceModified ))

	peopleUpdated.emit(demand,demand - oldDemand, satisfaction,satisfaction - oldSatisfaction)

func _on_orloj_cycle_complete() -> void:
	recalcualte_satisfaction_and_demand();
	recalculate_products_and_money();
	
	return

func _on_v_box_container_change_money(ammount: float) -> void:
	money += ammount


func _on_v_box_container_change_income(ammount: float) -> void:
	priceModified += ammount ## must be a percentage


func _on_v_box_container_change_demand(ammount: float) -> void:
	demandConstant += ammount


func _on_v_box_container_change_production(ammount: float) -> void:
	workersProductivity += ammount


func _on_v_box_container_change_worker_wage(ammount: float) -> void:
	workerSalary += ammount


func _on_v_box_container_change_areas_satisfaction(amount: float) -> void:
	satisfaction += amount
	
func _process(delta: float) -> void:
	GameState.currentMoney = money
	GameState.currentInStock = availableProducts
	GameState.currentProduction = workersProductivity
	GameState.currentDemand = demand

func _on_node_2d_enable_couriers() -> void:
	couriers = 2;
