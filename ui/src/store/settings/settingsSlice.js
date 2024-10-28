import { createSlice } from "@reduxjs/toolkit";

const initialState = {
  showminimap: true,
  showinfo: true,
  minimapsize: 1.0,
  speedometersize: 1.0,
  dynamicinfo: true,
  seatbeltalarm: true,
  showstreet: true,
  showhud: true,
  showcompass: true,
  cinematicmode: false,
  mphkmh: true,
  skullonfoot: false,
  showspeedometer: true,
  compassize: 1.0,
  fliphud: false,
};

export const counterSlice = createSlice({
  name: "settings",
  initialState,
  reducers: {
    update: (state, action) => {
      state.value = action.payload;
    },
  },
});

export const { update } = counterSlice.actions;

export default counterSlice.reducer;
