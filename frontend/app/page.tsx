"use client"

import CityStateForm from "@/app/components/city-state-form/Index";
import PostalCodeForm from "@/app/components/postal-code-form/Index";
import { useState } from "react";
import styles from "./page.module.css";
import { getForecast } from "./services/forecast.service";
import { ForecastData } from "./types/forecast";

export default function Home() {
  const [cityStatePostalCode, setCityStatePostalCode] = useState({
    city: "",
    state: "",
    postalCode: ""
  });

  const [forecastData, setForecastData] = useState<ForecastData>({
    cached: null,
    forecast: null
  })

  const handleChange = (values: any) => {
    setCityStatePostalCode(prev => {
      return {
        ...prev,
        ...values
      }
    })
  }

  const handleSubmit = async () => {
    const res = await getForecast({
      forecast: {
        city: cityStatePostalCode.city,
        state: cityStatePostalCode.state,
        postal_code: cityStatePostalCode.postalCode
      }
    })

    setForecastData(res)
  }

  return (
    <div className={styles.container}>
      <div className={styles.layout}>
        <div className={styles.header}>
          <h1>Forecastly</h1>
          <p>Your average forecast app</p>
        </div>
        <div className={styles.formContainer}>
          <div className={styles.forms}>
            <CityStateForm onChange={handleChange} />
            <span>Or</span>
            <PostalCodeForm onChange={handleChange} />
          </div>
          <button type="submit" className="button" onClick={handleSubmit}>
            Submit
          </button>
        </div>
        {forecastData.forecast && <div>
          <div className={styles.currentWeather}>
            <span><b>Current Temperature</b>: {forecastData.forecast.current.temp}</span>
            <span><b>Weather Type</b>: {forecastData.forecast.current.weather.type}</span>
            <span><b>Weather Description</b>: {forecastData.forecast.current.weather.description}</span>
          </div>
          <div>
            <h2>Cached: {`${forecastData.cached}`}</h2>
            {forecastData.forecast.daily.map(weather => {
              return <div key={weather.timestamp}>
                <span><b>High</b>{weather.high}</span>
                <span><b>Low</b>{weather.low}</span>
                <span><b>Weather Type</b>{weather.weather.type}</span>
                <span><b>Weather Description</b>{weather.weather.description}</span>
              </div>
            })}
          </div>
        </div>}
      </div>
    </div>
  );
}
