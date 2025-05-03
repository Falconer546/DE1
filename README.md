# FPGA Stopwatch & Countdown Timer on Nexys A7-50T

VHDL implementation of a multifunctional stopwatch and countdown timer with lap time support and 7-segment display interface. Designed for the Digilent Nexys A7-50T board using a modular, fully synchronous architecture.

## Features

* Stopwatch mode:  min  sec  decisecond
* Countdown timer mode:  min  sec  centisecond  --configurable via switches
* Lap-time display in stopwatch mode
* 8-digit multiplexed 7-segment display with decimal points
* Separate logic for:

  * Timing (clockLogic)
  * Display (segmentLogic)
  * Clock enable generation (clockEnable)
* Debounced and edge-detected control via push-buttons

## Architecture Overview


![DE1scheme](https://github.com/user-attachments/assets/f8de13e3-50c1-467e-b335-d4d2a87785f4)


## Requirements

* Board: Digilent Nexys A7-50T
* FPGA: Xilinx XC7A50T
* Toolchain: Vivado 2020.2 or newer
* Language: VHDL (fully synchronous design)

## File Structure

```
/src
├── clockEnable.vhd       -- Clock enable generator 
├── clockLogic.vhd        -- Core logic for stopwatch & timer
├── segmentLogic.vhd      -- Multiplexed 7-segment controller
├── Bin2Seg.vhd           -- Binary to segment decoder
├── Top.vhd               -- Top-level integration module
/testbench
├── tb_clockEnable.vhd
├── tb_clockLogic.vhd
├── tb_segmentLogic.vhd
/constraints
├── Nexys-A7-50T.xdc      -- Pin mapping file
```

## Controls

| Switch   | Function                           |
| -------  | ---------------------------------- |
| SW0      | Mode Select (0=Stopwatch, 1=Timer) |
| SW1–SW10 | Timer time select (1–10 minutes)   |


| Button | Function             |
| ------ | -------------------- |
| BTNU   | Start                |
| BTNC   | Reset                |
| BTNR   | Lap (Stopwatch only) |

## Testbenches

Each core module includes a simulation-ready testbench with basic waveform generation and signal assertions:

* tb\_clockEnable.vhd
* tb\_clockLogic.vhd
* tb\_segmentLogic.vhd

## Design Guidelines Followed

* No `rising_edge` on non-clock signals
* Modular & hierarchical structure
* Synchronous reset and edge detection
* No asynchronous logic
* No `inout` ports
* `wait` statements only used in testbenches

## Screenshots

> ![image](https://github.com/user-attachments/assets/7ff76ccf-64d2-4beb-a39d-36eec5c9ad8d)
> ![image2](https://github.com/user-attachments/assets/8e0926db-d1e1-4603-b698-8ad7ba7f59a9)



## License

MIT License
©2025 Jan Brokes & Jan Bozejovsky  VUT Brno

## Resources

* Digilent Nexys A7-50T Reference Manual: [https://digilent.com/reference/programmable-logic/nexys-a7/start](https://digilent.com/reference/programmable-logic/nexys-a7/start)
* Xilinx 7-Series FPGAs Overview: [https://www.xilinx.com/products/silicon-devices/fpga/7-series.html](https://www.xilinx.com/products/silicon-devices/fpga/7-series.html)

## Other help from forum and videos
https://www.reddit.com/r/VHDL/comments/z6f7ke/error_10818_on_timer_stopwatch_code/
https://stackoverflow.com/questions/30245803/vhdl-my-timer-does-not-work
https://www.youtube.com/watch?v=EKX1K9oV_c4
https://www.thecodingforums.com/threads/vhdl-programming.972568/
