extends PanelContainer

var moneyLabel: Label;
var productsLabel: Label;
var demand: Label;
var satisfaction: Label;
var productsPerCycleLabel: Label;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moneyLabel = get_node("MarginContainer/HBoxContainer/Money");
	productsLabel = get_node("MarginContainer/HBoxContainer/Products");
	demand = get_node("MarginContainer/HBoxContainer/Demand");
	satisfaction = get_node("MarginContainer/HBoxContainer/Satisfaction");
	pass # Replace with function body.


func _on_resource_counter_resources_updated(newMoney: float, newProducts: float) -> void:
	moneyLabel.text = "Money %s." % str(newMoney).pad_decimals(2);
	productsLabel.text = "Products %s." % str(newProducts).pad_decimals(2);

	pass # Replace with function body.


func _on_resource_counter_people_updated(newDemand: float, newSatisfaction: float) -> void:
	demand.text = "Demand %s." % str(newDemand).pad_decimals(2);
	satisfaction.text = "Satisfaction %s. procent" % str(newSatisfaction).pad_decimals(2);
	pass # Replace with function body.
