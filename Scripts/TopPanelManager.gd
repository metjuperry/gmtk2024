extends PanelContainer

var moneyLabel: Label;
var productsLabel: Label;
var productionLabel: Label;
var demand: Label;
var satisfaction: Label;
var productsPerCycleLabel: Label;
var shippingLabel: Label;


var moneyLabelChange: Label;
var productsLabelChange: Label;
var productionLabelChange: Label;
var demandLabelChange: Label;
var satisfactionLabelChange: Label;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moneyLabel = get_node("MarginContainer/VBoxContainer/HBoxContainer/MoneyContainer/HBoxContainer/Label");
	productsLabel = get_node("MarginContainer/VBoxContainer/HBoxContainer/ProductsContainer/HBoxContainer/Products");
	productionLabel = get_node("MarginContainer/VBoxContainer/HBoxContainer/ProductionContainer/HBoxContainer/Production");
	demand = get_node("MarginContainer/VBoxContainer/HBoxContainer/DemandContainer/HBoxContainer/Demand");
	shippingLabel = get_node("MarginContainer/VBoxContainer/HBoxContainer/ShippingContainer/HBoxContainer/Shipping");
	
	moneyLabelChange = get_node("MarginContainer/VBoxContainer/HBoxContainer/MoneyContainer/MoneyCHange");
	productsLabelChange = get_node("MarginContainer/VBoxContainer/HBoxContainer/ProductsContainer/ProductsChange");
	productionLabelChange = get_node("MarginContainer/VBoxContainer/HBoxContainer/ProductionContainer/ProductionChange");
	demandLabelChange = get_node("MarginContainer/VBoxContainer/HBoxContainer/DemandContainer/DemandChange");
	
	pass # Replace with function body.

func _process(delta: float) -> void:
	moneyLabel.text = str(GameState.currentMoney).pad_decimals(2)
	productionLabel.text = str(GameState.currentProduction).pad_decimals(2)
	productsLabel.text = str(GameState.currentInStock).pad_decimals(2)
	demand.text = str(GameState.currentDemand).pad_decimals(2)
	shippingLabel.text = str(GameState.currentCouriers).pad_decimals(2)
	
	get_node("MarginContainer/VBoxContainer/HBoxContainer/SalaryContainer/HBoxContainer/Label").text = str(GameState.currentSalary).pad_decimals(2)
	get_node("MarginContainer/VBoxContainer/HBoxContainer/UnitPriceContainer/HBoxContainer/Label").text = str(GameState.currentPricePerUnit).pad_decimals(2)

func _on_resource_counter_resources_updated(newMoney: float, moneyChange: float, newProducts: float, productsChange: float, workerProductivity: float, couriers: int) -> void:
	if(moneyChange != 0):
		moneyLabelChange.text ="+ " + str(moneyChange).pad_decimals(2) if moneyChange > 0 else str(moneyChange).pad_decimals(2);
		moneyLabelChange.add_theme_color_override("font_color",getColor(moneyChange));
	else:
		moneyLabelChange.text = "";
	
	if(productsChange != 0):
		productsLabelChange.text = "+ " + str(productsChange).pad_decimals(2) if productsChange > 0 else str(productsChange).pad_decimals(2);
		productsLabelChange.add_theme_color_override("font_color",getColor(productsChange))
	else:
		productsLabelChange.text = ""

	pass # Replace with function body.


func _on_resource_counter_people_updated(newDemand: float,demandChange:float, newSatisfaction: float, satisfactionChange: float) -> void:
	if(demandChange != 0):
		demandLabelChange.text = "+ " + str(demandChange).pad_decimals(2) if demandChange > 0 else str(demandChange).pad_decimals(2);
		demandLabelChange.add_theme_color_override("font_color",getColor(demandChange))
	else:
		demandLabelChange.text = ""
	demand.text = str(newDemand).pad_decimals(2);

	pass # Replace with function body.


func getColor(number: float) -> Color:
	if number>0:
		return Color.html("#39e75f")
	elif number<0:
		return Color.html("#ff474c")
	else:
		return Color.html("#FFFFFF")


func _on_node_2d_enable_couriers() -> void:
	get_node("MarginContainer/VBoxContainer/HBoxContainer/ShippingContainer").visible = true
	shippingLabel.text = "2.0";
