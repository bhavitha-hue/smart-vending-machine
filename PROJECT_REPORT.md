Smart AI-Based Multi-Payment Vending Machine using Verilog HDL
Project Report
________________________________________
1. Introduction
The Smart AI-Based Multi-Payment Vending Machine is a digital hardware system designed using Verilog HDL. The project simulates a modern vending machine capable of handling:
•	Multiple product selection
•	Multiple quantities
•	Dynamic pricing
•	Cash payment
•	QR payment
•	Fraud detection
•	Timeout handling
•	Recommendation engine
•	Inventory management
•	Transaction logging
•	Admin control
The design follows a modular hardware architecture where each subsystem performs a dedicated task.
________________________________________
2. Objectives
The main objectives of the project are:
•	To design a smart vending machine using Verilog HDL
•	To support both cash and QR-based payments
•	To implement inventory monitoring and stock verification
•	To implement product recommendation
•	To provide dynamic pricing based on demand
•	To detect fraud and lock the machine
•	To maintain transaction records
•	To simulate real-world vending machine operations
________________________________________
3. Features of the System
Main Features
1. Multi Product Selection
Users can select multiple products simultaneously.
2. Multiple Quantity Handling
Each product can be purchased in different quantities.
3. Dynamic Pricing
Prices vary according to demand levels.
4. Recommendation Engine
The system recommends related products.
5. Cash Payment Support
Accepts coins and verifies payment.
6. QR Payment Support
Supports digital QR-based transactions.
7. Fraud Detection
Detects suspicious activities and locks the machine.
8. Timeout Handling
Cancels delayed or inactive transactions.
9. Inventory Management
Tracks available stock and updates inventory.
10. Transaction Logging
Stores transaction information for monitoring.
11. Admin Controller
Allows admin unlock and maintenance.
________________________________________
4. Overall System Architecture

      User Input   
           |
           |
     Cart Manager     
           |
           |
  Recommendation Unit 
           |
                            |
   Inventory Manager   
                            |
           |
    Dynamic Pricing     
                            |
           |
     Payment System    
    Cash / QR Payment  
           |
           |
      Fraud Detector
           |                  
           |
       Vending FSM     
                            |
           |
   Product Dispensing  
                            |
           |
   Transaction Logger  

________________________________________
5. FSM Flowchart
            
               IDLE   
                 |
                 v
           SELECT PRODUCT   
                 |
                 v
            CHECK STOCK      
                 |
       STOCK OK? |
          YES    | NO
                 v
           DYNAMIC PRICING  
                 |
                 v
           RECOMMENDATION  
                 |
                 v
           SELECT PAYMENT   
                 |
         -----------------
         |               |
         v               v
    INSERT CASH       GENERATE QR  
         |                |
         v                v
    PAYMENT DONE?      VERIFY QR      
         |                   |
         ---------------------
                  |
                  v
           PAYMENT SUCCESS  
                 |
                 v
           DISPENSE PRODUCT 
                 |
                 v
          UPDATE INVENTORY 
                 |
                 v
          GENERATE RECEIPT 
                 |
                 v
                IDLE 
________________________________________
6. Module Description
6.1 Vending FSM
Purpose
Controls the overall operation of the vending machine.
Functions
•	Product selection
•	Stock verification
•	Payment handling
•	Product dispensing
•	Error handling
•	Fraud locking
States Used
•	IDLE
•	SELECT_PRODUCT
•	CHECK_STOCK
•	DYNAMIC_PRICING
•	RECOMMENDED_PRODUCT
•	SELECT_PAYMENT
•	INSERT_CASH
•	GENERATE_QR
•	WAIT_FOR_SCAN
•	VERIFY_PAYMENT
•	PAYMENT_SUCCESS
•	RETURN_CHANGE
•	DISPENSE_PRODUCT
•	UPDATE_INVENTORY
•	GENERATE_RECEIPT
•	TRANSACTION_LOG
•	UPDATE_HISTORY
•	CANCEL_TRANSACTION
•	TIMEOUT_STATE
•	LOCK_MACHINE
________________________________________
6.2 Cart Manager
Purpose
Stores and updates selected products.
Functions
•	Adds user-selected products
•	Updates quantities
•	Adds recommended products
________________________________________
6.3 Recommendation Engine
Purpose
Suggests products based on user cart.
Example
•	If item0 is selected, item1 may be recommended.
•	If item2 is selected, item3 may be recommended.
Benefits
•	Increases sales
•	Simulates AI recommendation system
________________________________________
6.4 Inventory Manager
Purpose
Maintains stock levels.
Functions
•	Checks stock availability
•	Updates inventory after dispensing
•	Prevents invalid purchases
________________________________________
6.5 Dynamic Pricing Module
Purpose
Adjusts prices according to demand.
Demand Levels
Demand Level	Pricing Action
Low	10% Discount
Normal	Original Price
High	10% Price Increase
________________________________________
6.6 Payment Controller
Purpose
Handles cash and QR payments.
Cash Payment Features
•	Coin insertion
•	Balance checking
•	Change return
QR Payment Features
•	QR verification
•	Digital payment support
________________________________________
6.7 QR Payment FSM
Purpose
Controls QR transaction sequence.
Operations
•	QR activation
•	Payment validation
•	Timeout handling
•	Fraud handling
________________________________________
6.8 Fraud Detector
Purpose
Detects suspicious activities.
Example Conditions
•	Invalid payment behavior
•	Abnormal coin input
•	QR timeout
Action
Locks the machine.
________________________________________
6.9 Timeout Controller
Purpose
Cancels inactive transactions.
Functions
•	Prevents machine hanging
•	Improves reliability
________________________________________
6.10 Transaction Logger
Purpose
Maintains transaction history.
Stored Information
•	Number of transactions
•	Last transaction amount
________________________________________
6.11 Admin Controller
Purpose
Provides maintenance control.
Functions
•	Unlock machine after fraud
•	Enable maintenance/refill
________________________________________
7. Test Cases Implemented
Test Case	Description
TC1	Single product single quantity
TC2	Single product multiple quantity
TC3	Multiple products multiple quantities
TC4	Insufficient cash payment
TC5	QR payment success
TC6	QR timeout failure
TC7	Transaction cancellation
TC8	Fraud detection
TC9	Admin unlock
TC10	Out of stock condition
TC11	Recommendation acceptance
TC12	High demand dynamic pricing
________________________________________
8. Simulation Tools Used
Software
•	Icarus Verilog (iverilog)
•	GTKWave
•	Visual Studio Code
Simulation Commands
Compile
iverilog -o sim tb/top_module_tb.v src/*.v
Run Simulation
vvp sim
Open Waveform
gtkwave wave.vcd
________________________________________
9. Waveform Analysis
The waveform verifies:
•	FSM state transitions
•	Payment success/failure
•	Timeout conditions
•	Fraud detection
•	Inventory updates
•	Product dispensing
•	QR validation
Important signals observed:
•	state
•	total_price
•	qr_done
•	cash_done
•	timeout
•	fraud_detected
•	stock_available
________________________________________
10. Advantages of the System
•	Supports modern digital payments
•	Modular and scalable architecture
•	Realistic vending machine simulation
•	Improved customer interaction
•	Smart recommendation capability
•	Reliable fraud detection
•	Automated inventory tracking
________________________________________
11. Applications
•	Smart retail systems
•	Automated kiosks
•	Railway stations
•	Shopping malls
•	Airports
•	Educational FPGA projects
•	Embedded system research
________________________________________
12. Future Enhancements
Future improvements may include:
•	Real-time analytics
•	Voice interaction
•	Touchscreen interface
•	OTP-based admin access
________________________________________
13. Conclusion
The Smart AI-Based Multi-Payment Vending Machine successfully demonstrates the implementation of a modern vending machine using Verilog HDL. The system integrates inventory management, digital payments, recommendation systems, fraud detection, and dynamic pricing into a single modular architecture.
The project provides strong understanding of:
•	Finite State Machines
•	Digital system design
•	RTL modeling
•	FPGA-oriented architecture
•	Modular hardware development
•	Simulation and verification
The project is scalable and can be further extended into a real FPGA-based smart vending solution.
________________________________________
THANK YOU
