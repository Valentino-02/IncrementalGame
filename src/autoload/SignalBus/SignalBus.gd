extends Node

@warning_ignore_start("unused_signal")
signal cyclePassed(toCycle: Types.Cycle)
signal sunCurrencyChanged(newValue: int)
signal moonCurrencyChanged(newValue: int)
signal maxCurrencyChanged(newValue: int)
signal maxCurrencyReached()
signal currencyChanged(sunNewValue: int, moonNewValue: int)
signal powerUpBought(data: PowerUpResource)
signal powerUpIconClicked(data: PowerUpResource)
signal unlockedPowerUpsChanged(newIds: Array[PowerUpManager.PowerUpId])
signal ownedPowerUpsChanged(newIds: Array[PowerUpManager.PowerUpId])
signal passTimeClicked
signal tickAdvanced
signal coinCollected(type: Types.Cycle)
