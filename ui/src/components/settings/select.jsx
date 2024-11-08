import { React, useState } from "react";
import { nuicallback } from "../../utils/nuicallback";




const Select = (data) => {


  const [input, setinput] = useState(data.value);

  const handleinput = (state,option) => {
    setinput(state)
    nuicallback("settings",{option: option,value: state})
  };

  return (
    <>
      <div className='option'>
        <div>{data.title}</div>
        <div style={{color: '#88cfcd'}}  className='select-value'>
          <div
            onClick={() => handleinput(true,data.name)}
            style={{ opacity: input == true ? "100%" : "50%" }}
          >
            {data.option1}
          </div>
          <div
            onClick={() => handleinput(false,data.name)}
            style={{ opacity: input == false ? "100%" : "50%" }}
          >
           {data.option2}
          </div>
        </div>
      </div>
    </>
  );
};

export default Select;
