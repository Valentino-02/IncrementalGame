extends Node

@warning_ignore_start("unused_signal")
signal cyclePassed(toCycle: Types.Cycle)
signal sunCurrencyChanged(newValue: int)
signal moonCurrencyChanged(newValue: int)
signal currencyChanged(sunNewValue: int, moonNewValue: int)
signal powerUpBought(data: PowerUpResource)
signal powerUpIconClicked(data: PowerUpResource)
signal passTimeClicked
signal tickAdvanced
