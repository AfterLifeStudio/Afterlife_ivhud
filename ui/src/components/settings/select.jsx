import { React, useState } from "react";
import { nuicallback } from "../../utils/nuicallback";




const Select = (data) => {

  console.log(data.value)
  const [input, setinput] = useState(data.value);

  const handleinput = (input,option) => {
    setinput(input)
    nuicallback("settings",{option,input})
  };

  return (
    <>
      <div className='option'>
        <div>{data.title}</div>
        <div className='select-value'>
          <div
            onClick={() => handleinput(true,data.option)}
            style={{ opacity: input == true ? "100%" : "50%" }}
          >
            {data.option1}
          </div>
          <div
            onClick={() => handleinput(false,data.option)}
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
