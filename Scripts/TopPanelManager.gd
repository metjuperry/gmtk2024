extends PanelContainer

var moneyLabel: Label;
var productsLabel: Label;
var demand: Label;
var satisfaction: Label;
var productsPerCycleLabel: Label;


var moneyLabelChange: Label;
var productsLabelChange: Label;
var demandLabelChange: Label;
var satisfactionLabelChange: Label;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	moneyLabel = get_node("MarginContainer/VBoxContainer/HBoxContainer/Money");
	productsLabel = get_node("MarginContainer/VBoxContainer/HBoxContainer/Products");
	demand = get_node("MarginContainer/VBoxContainer/HBoxContainer/Demand");
	satisfaction = get_node("MarginContainer/VBoxContainer/HBoxContainer/Satisfaction");
	
	moneyLabelChange = get_node("MarginContainer/VBoxContainer/Changes/Money");
	productsLabelChange = get_node("MarginContainer/VBoxContainer/Changes/Products");
	demandLabelChange = get_node("MarginContainer/VBoxContainer/Changes/Demand");
	satisfactionLabelChange = get_node("MarginContainer/VBoxContainer/Changes/Satisfaction");
	
	pass # Replace with function body.


func _on_resource_counter_resources_updated(newMoney: float, moneyChange: float, newProducts: float, productsChange: float) -> void:
	
	moneyLabelChange.text = str(moneyChange);
	moneyLabelChange.add_theme_color_override("font_color",getColor(moneyChange));
	moneyLabel.text = "Money %s." % str(newMoney).pad_decimals(2);
	
	productsLabelChange.text = str(newProducts)
	productsLabelChange.add_theme_color_override("font_color",getColor(newProducts))
	productsLabel.text = "Products %s." % str(newProducts).pad_decimals(2);

	pass # Replace with function body.


func _on_resource_counter_people_updated(newDemand: float,demandChange:float, newSatisfaction: float, satisfactionChange: float) -> void:
	demandLabelChange.text = str(demandChange)
	demandLabelChange.add_theme_color_override("font_color",getColor(demandChange))
	demand.text = "Demand %s." % str(newDemand).pad_decimals(2);
	
	satisfactionLabelChange.text = str(satisfactionChange)
	satisfactionLabelChange.add_theme_color_override("font_color",getColor(satisfactionChange))
	satisfaction.text = "Satisfaction %s. procent" % str(newSatisfaction).pad_decimals(2);

	pass # Replace with function body.


func getColor(number: float) -> Color:
	if number>0:
		return Color.html("#39e75f")
	elif number<0:
		return Color.html("#ff474c")
	else:
		return Color.html("#FFFFFF")
