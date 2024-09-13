export interface GetForecastPayload {
  forecast: {
    city: string;
    state: string;
    postal_code: string;
  }
}

export interface ForecastData {
  forecast: null | {
    current: {
      temp: number;
      weather: {
        type: string;
        description: string;
      };
    };
    daily: Array<{
      timestamp: number
      high: number;
      low: number;
      weather: {
        type: string;
        description: string;
      };
    }>
  };
  cached: null | boolean;
}