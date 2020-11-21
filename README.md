OZ Meds Traits Bundle
===========

A [Project Zomboid](https://steamcommunity.com/sharedfiles/filedetails/?id=2294579476) bundle for easy creation of traits.

**build41** support is done.

## Documentation

1. [Install](#installation)
1. [Basic usage](#basic-usage)
    1. [Creating trait](#creating-trait)

## Installation

With [Steam workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2294579476) (recommended)

## Basic usage

### Creating trait

```lua
OzMedsCoreBundle.ZCore:getContainer():register(
    OzMedsTraitsBundle.Entity.Trait, --instantiate a new entity
    'OzMedsTraitsBundle.Entity.Trait.AdultOnsetDiabetes',
    {
        {
            name = getText('Trait_AdultOnsetDiabetes_Name'),
            description = getText('Trait_AdultOnsetDiabetes_Description'),
            cost = -8,
            freeRecipes = {},
            freeTraits = {},
            xpBoosts = {},
            xpBoostValues = {},
            mutualExclusives = {},
        },
    },
    'oz_meds.traits_bundle.trait' --important tag for all new traits
)
```
