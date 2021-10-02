# 0x18. Webstack monitoring

## Content:

* **0. Sign up for Datadog and install datadog-agent**
  For this task head to https://www.datadoghq.com/ and sign up for a free Datadog account.
    * Install datadog-agent on web-01
    * Create an application key
    * Copy-paste in your Intranet user profile (here) your DataDog API key and your DataDog application key.
    * Your server web-01 should be visible in Datadog under the host name XX-web-01
      * You can validate it by using DataDog API
      * If needed, you will need to update the hostname of your server

* **1. Monitor some metrics**
  Set up some monitors within the Datadog dashboard to monitor and alert you of a few.
    * Set up a monitor that checks the number of read requests issued to the device per second.
    * Set up a monitor that checks the number of write requests issued to the device per second.

* **2. Create a dashboard**
  * [2-setup_datadog](./2-setup_datadog): Text file containing
  the dashboard ID.
