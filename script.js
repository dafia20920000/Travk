document.getElementById('trackButton').addEventListener('click', async function() {
    const userAgent = navigator.userAgent;
    const ipResponse = await fetch('https://api.ipify.org?format=json');
    const ipData = await ipResponse.json();
    const ipAddress = ipData.ip;

    const battery = await navigator.getBattery();
    const batteryStatus = battery.level * 100 + '%';
    const isCharging = battery.charging ? 'Yes' : 'No';

    const deviceInfo = {
        userAgent: userAgent,
        ipAddress: ipAddress,
        batteryStatus: batteryStatus,
        isCharging: isCharging,
        deviceName: navigator.userAgent.includes('Android') ? 'Android Device' : 'Other'
    };

    // Send data to your backend server
    const response = await fetch('https://dafia20920000.github.io/Travk/', { // Replace with your backend URL
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(deviceInfo)
    });

    if (response.ok) {
        document.getElementById('result').innerText = 'Information sent successfully!';
    } else {
        document.getElementById('result').innerText = 'Failed to send information.';
    }
});
