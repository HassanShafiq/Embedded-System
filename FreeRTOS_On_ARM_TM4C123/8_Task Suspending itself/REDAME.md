### Task Control API in FreeRTOS - Suspending a task on runtime without handle.</br>
This coding implementation gives an overview of task suspension using vTaskSuspend() without task handles, available in Task Control API in FreeRTOS using port for Tiva C Launchpad (TM4C123GH6PM). The implementation also explores the various options available in **FreeRTOSConfig.h** file to configure RTOS scheduler at various modes, task priorities and many other options.</br>

The implementation toggles on-board LEDs using a pseudo delay for 3 tasks with same priorities: 
- vRedLedControllerTask(void *pvParamters)
- vGreedLedControllerTask(void *pvParamters)
- vBlueLedControllerTask(void *pvParamters)</br>

where the tasks suspend themselves, while the **configTICK_RATE_HZ** is set at 1000Hz (1 milli second time quanta). Using vTaskSuspend() without a task handle suspends a task itself, a task can also suspend another task.
