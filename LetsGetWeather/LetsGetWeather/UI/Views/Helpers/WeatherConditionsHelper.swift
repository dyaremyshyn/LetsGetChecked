//
//  WeatherConditionsHelper.swift
//  LetsGetWeather
//
//  Created by Dmytro Yaremyshyn on 29/06/2024.
//

import UIKit

struct WeatherConditionsHelper {
    static func getBackgroundImageFor(model: CurrentModel?) -> UIImage? {
        if !(NSNumber(value: model?.isDay ?? 1).boolValue) {
            return UIImage(named: "night")
        }
        
        switch model?.condition?.text {
        case WeatherCondition.sunny.rawValue, WeatherCondition.sunnyPT.rawValue:
            return UIImage(named: "sun")
        case WeatherCondition.mist.rawValue, WeatherCondition.mistPT.rawValue, 
            WeatherCondition.fog.rawValue, WeatherCondition.fogPT.rawValue:
            return UIImage(named: "fog")
        case WeatherCondition.heavyRain.rawValue, WeatherCondition.heavyRainPT.rawValue, 
            WeatherCondition.lightRain.rawValue, WeatherCondition.lightRainPT.rawValue,
            WeatherCondition.moderateRain.rawValue, WeatherCondition.moderateRainPT.rawValue,
            WeatherCondition.lightRainShower.rawValue, WeatherCondition.lightRainShowerPT.rawValue,
            WeatherCondition.patchyLightRain.rawValue, WeatherCondition.patchyLightRainPT.rawValue,
            WeatherCondition.patchyRainNearby.rawValue, WeatherCondition.patchyRainNearbyPT.rawValue,
            WeatherCondition.lightFreezingRain.rawValue, WeatherCondition.lightFreezingRainPT.rawValue,
            WeatherCondition.torrentialRainShower.rawValue, WeatherCondition.torrentialRainShowerPT.rawValue,
            WeatherCondition.heavyRainAtTimes.rawValue, WeatherCondition.heavyRainAtTimesPT.rawValue,
            WeatherCondition.moderateRainAtTimes.rawValue, WeatherCondition.moderateRainAtTimesPT.rawValue,
            WeatherCondition.moderateOrHeavyRainShower.rawValue, WeatherCondition.moderateOrHeavyRainShowerPT.rawValue,
            WeatherCondition.moderateOrHeavyFreezingRain.rawValue, WeatherCondition.moderateOrHeavyFreezingRainPT.rawValue:
            return UIImage(named: "rain")
        case WeatherCondition.heavySnow.rawValue, WeatherCondition.heavySnowPT.rawValue,
            WeatherCondition.lightSnow.rawValue, WeatherCondition.lightSnowPT.rawValue,
            WeatherCondition.blowingSnow.rawValue, WeatherCondition.blowingSnowPT.rawValue,
            WeatherCondition.moderateSnow.rawValue, WeatherCondition.moderateSnowPT.rawValue,
            WeatherCondition.patchyHeavySnow.rawValue, WeatherCondition.patchyHeavySnowPT.rawValue,
            WeatherCondition.patchyLightSnow.rawValue, WeatherCondition.patchyLightSnowPT.rawValue,
            WeatherCondition.lightSnowShowers.rawValue, WeatherCondition.lightSnowShowersPT.rawValue,
            WeatherCondition.patchySnowNearby.rawValue, WeatherCondition.patchySnowNearbyPT.rawValue,
            WeatherCondition.patchyModerateSnow.rawValue, WeatherCondition.patchyModerateSnowPT.rawValue,
            WeatherCondition.moderateOrHeavySnowShowers.rawValue, WeatherCondition.moderateOrHeavySnowShowersPT.rawValue:
            return UIImage(named: "snow")
        case WeatherCondition.thunderyOutbreaksNearby.rawValue, WeatherCondition.thunderyOutbreaksNearbyPT.rawValue,
            WeatherCondition.patchyLightRainWithThunder.rawValue, WeatherCondition.patchyLightRainWithThunderPT.rawValue,
            WeatherCondition.patchyLightSnowWithThunder.rawValue, WeatherCondition.patchyLightSnowWithThunderPT.rawValue,
            WeatherCondition.moderateOrHeavyRainWithThunder.rawValue, WeatherCondition.moderateOrHeavyRainWithThunderPT.rawValue,
            WeatherCondition.moderateOrHeavySnowWithThunder.rawValue, WeatherCondition.moderateOrHeavySnowWithThunderPT.rawValue:
            return UIImage(named: "thunder")
        default:
            return UIImage(named: "day")
        }
    }
}


fileprivate enum WeatherCondition: String {
    // English Conditions from wheather api
    case sunny = "Sunny"
    case mist = "Mist"
    case fog = "Fog"
    case partlyCloudy = "Partly cloudy"
    case cloudy = "Cloudy"
    case overcast = "Overcast"
    case patchyRainNearby = "Patchy rain nearby"
    case patchySnowNearby = "Patchy snow nearby"
    case patchySleetNearby = "Patchy sleet nearby"
    case patchyFreezingDrizzleNearby = "Patchy freezing drizzle nearby"
    case thunderyOutbreaksNearby = "Thundery outbreaks nearby"
    case blowingSnow = "Blowing snow"
    case blizzard = "Blizzard"
    case freezingFog = "Freezing fog"
    case patchyLightDrizzle = "Patchy light drizzle"
    case lightDrizzle = "Light drizzle"
    case freezingDrizzle = "Freezing drizzle"
    case heavyFreezingDrizzle = "Heavy freezing drizzle"
    case patchyLightRain = "Patchy light rain"
    case lightRain = "Light rain"
    case moderateRainAtTimes = "Moderate rain at times"
    case moderateRain = "Moderate rain"
    case heavyRainAtTimes = "Heavy rain at times"
    case heavyRain = "Heavy rain"
    case lightFreezingRain = "Light freezing rain"
    case moderateOrHeavyFreezingRain = "Moderate or heavy freezing rain"
    case lightSleet = "Light sleet"
    case moderateOrHeavySleet = "Moderate or heavy sleet"
    case patchyLightSnow = "Patchy light snow"
    case lightSnow = "Light snow"
    case patchyModerateSnow = "Patchy moderate snow"
    case moderateSnow = "Moderate snow"
    case patchyHeavySnow = "Patchy heavy snow"
    case heavySnow = "Heavy snow"
    case icePellets = "Ice pellets"
    case lightRainShower = "Light rain shower"
    case moderateOrHeavyRainShower = "Moderate or heavy rain shower"
    case torrentialRainShower = "Torrential rain shower"
    case lightSleetShowers = "Light sleet showers"
    case moderateOrHeavySleetShowers = "Moderate or heavy sleet showers"
    case lightSnowShowers = "Light snow showers"
    case moderateOrHeavySnowShowers = "Moderate or heavy snow showers"
    case lightShowersOfIcePellets = "Light showers of ice pellets"
    case moderateOrHeavyShowersOfIcePellets = "Moderate or heavy showers of ice pellets"
    case patchyLightRainWithThunder = "Patchy light rain with thunder"
    case moderateOrHeavyRainWithThunder = "Moderate or heavy rain with thunder"
    case patchyLightSnowWithThunder = "Patchy light snow with thunder"
    case moderateOrHeavySnowWithThunder = "Moderate or heavy snow with thunder"
    
    // Portuguese Conditions from wheather api
    case sunnyPT = "Sol"
    case partlyCloudyPT = "Parcialmente nublado"
    case cloudyPT = "Nublado"
    case overcastPT = "Encoberto"
    case mistPT = "Neblina"
    case patchyRainNearbyPT = "Possibilidade de chuva irregular"
    case patchySnowNearbyPT = "Possibilidade de neve irregular"
    case patchySleetNearbyPT = "Possibilidade de neve molhada irregular"
    case patchyFreezingDrizzleNearbyPT = "Possibilidade de chuvisco gelado irregular"
    case thunderyOutbreaksNearbyPT = "Possibilidade de trovoada"
    case blowingSnowPT = "Rajadas de vento com neve"
    case blizzardPT = "Nevasca"
    case fogPT = "Nevoeiro"
    case freezingFogPT = "Nevoeiro gelado"
    case patchyLightDrizzlePT = "Chuvisco irregular"
    case lightDrizzlePT = "Chuvisco"
    case freezingDrizzlePT = "Chuvisco gelado"
    case heavyFreezingDrizzlePT = "Chuvisco forte gelado"
    case patchyLightRainPT = "Chuva fraca irregular"
    case lightRainPT = "Chuva fraca"
    case moderateRainAtTimesPT = "Períodos de chuva moderada"
    case moderateRainPT = "Chuva moderada"
    case heavyRainAtTimesPT = "Períodos de chuva forte"
    case heavyRainPT = "Chuva forte"
    case lightFreezingRainPT = "Chuva fraca e gelada"
    case moderateOrHeavyFreezingRainPT = "Chuva gelada moderada ou forte"
    case lightSleetPT, lightSnowShowersPT = "Chuva fraca com neve"
    case moderateOrHeavySleetPT = "Chuva forte ou moderada com neve"
    case patchyLightSnowPT = "Queda de neve irregular e fraca"
    case lightSnowPT = "Queda de neve fraca"
    case patchyModerateSnowPT = "Queda de neve moderada e irregular"
    case moderateSnowPT = "Queda de neve moderada"
    case patchyHeavySnowPT = "Queda de neve forte e irregular"
    case heavySnowPT = "Neve intensa"
    case icePelletsPT = "Granizo"
    case lightRainShowerPT = "Aguaceiros fracos"
    case moderateOrHeavyRainShowerPT = "Aguaceiros moderados ou fortes"
    case torrentialRainShowerPT = "Chuva torrencial"
    case lightSleetShowersPT = "Aguaceiros fracos com neve"
    case moderateOrHeavySleetShowersPT = "Aguaceiros moderados ou fortes com neve"
    case moderateOrHeavySnowShowersPT = "Chuva moderada ou forte com neve"
    case lightShowersOfIcePelletsPT = "Aguaceiros fracos com granizo"
    case moderateOrHeavyShowersOfIcePelletsPT = "Aguaceiros moderados ou fortes com granizo"
    case patchyLightRainWithThunderPT = "Chuva fraca irregular com trovoada"
    case moderateOrHeavyRainWithThunderPT = "Chuva moderada ou forte com trovoada"
    case patchyLightSnowWithThunderPT = "Neve fraca irregular com trovoada"
    case moderateOrHeavySnowWithThunderPT = "Neve moderada ou forte com trovoada"
}
