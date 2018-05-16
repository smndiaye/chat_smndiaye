// API response status checker
export const CheckStatus = (response) => {
  if (response.status >= 200 && response.status < 300) {
    return response.json();
  }
  return response.json().then((json) => {
    const error = new Error(json.message || response.statusText);
    error.response = response;
    error.status = response.status;
    throw error;
  });
};

// Array of { value: 18, label: 18 } for age drop down
export const AgeArrayOfHash = (min, max) => {
  const output = [];
  for (let i = min; i <= max; i++) {
    output.push({value: i, label: i})
  }
  return output;
};