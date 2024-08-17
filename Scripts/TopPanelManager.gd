extends PanelContainer

var moneyLabel: Label;
var productsLabel: Label;
var productsPerCycleLabel: Label;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moneyLabel = get_node("MarginContainer/HBoxContainer/Money");
	productsLabel = get_node("MarginContainer/HBoxContainer/Products");
	
	pass # Replace with function body.


func _on_resource_counter_resources_updated(newMoney: float, newProducts: float) -> void:
	moneyLabel.text = "Money %s." % str(newMoney).pad_decimals(2);
	productsLabel.text = "Products %s." % str(newProducts).pad_decimals(2);
	pass # Replace with function body.
