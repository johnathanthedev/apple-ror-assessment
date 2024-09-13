import { GetForecastPayload } from "@/app/types/forecast";
import { API_URL } from "@/config/constants";

export const getForecast = async (payload: GetForecastPayload) => {
    const responseRaw = await fetch(`${API_URL}/forecast`, {
    method: 'POST',
    headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(payload),
  });
  const responseJson = await responseRaw.json();

  return responseJson;

}