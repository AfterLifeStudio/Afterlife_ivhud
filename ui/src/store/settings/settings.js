import { createSlice } from '@reduxjs/toolkit'

const initialState = {
    showhud: true,
    cinematicmode: false,
    fliphud: false,
    showminimap: true,
    skullonfoot: false,
    minimapsize: 1.0,
    showspeedometer: true,
    speedometersize: 1.0,
    speedunit: 'KMH',
    compassize: 1.0,
    showcompass: false,
    showstreet: false,
    seatbeltalarm: true,
    showinfo: false,
    dynamicinfo: false,
}

export const settingsSlice = createSlice({
  name: 'settings',
  initialState,
  reducers: {
    addsettings: (state,action) => [...state, ...action.payload],
  },
})

export const {addsettings, addSinglesettings} = settingsSlice.actions

export default settingsSlice.reducer