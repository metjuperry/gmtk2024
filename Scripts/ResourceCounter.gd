extends Node

signal resourcesUpdated(newMoney: float, newProducts: float)

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

func _on_orloj_cycle_complete() -> void:
	# Each courier working at their effectivenes, rounded up.
	var courierCapacity = ceil(couriers * courierEffectivenes);
	# The lowest nmumber of these is the one we actually sold
	var actuallySoldProducts = min(availableProducts, courierCapacity, demand)
	
	
	# Sold products times money + (or minus) modifier
	money += actuallySoldProducts * (basePricePerProduct + (basePricePerProduct/100.0 * priceModified ))
	
	# Remove stock, pay salary
	availableProducts -= actuallySoldProducts;
	money -= (workers * workerSalary) + (couriers * courierSalary)
	
	# get new stock
	availableProducts += workersProductivity;
	
	resourcesUpdated.emit(money, availableProducts)
	
	return
