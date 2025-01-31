document.addEventListener('DOMContentLoaded', function() {
    console.log('Lum Core UI carregada!');
});

window.addEventListener('message', function(event) {
    if (event.data.action === 'openShop') {
        document.getElementById('shop').style.display = 'block';
        document.getElementById('shop-name').innerText = event.data.shop.name;
        const itemsList = document.getElementById('shop-items');
        itemsList.innerHTML = '';
        event.data.shop.items.forEach((item, index) => {
            const li = document.createElement('li');
            li.innerText = `${item.label} - $${item.price}`;
            li.addEventListener('click', () => {
                fetch(`https://lum-core/buyItem`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ itemIndex: index })
                }).then(resp => resp.json()).then(data => {
                    if (data.success) {
                        alert(data.message);
                    } else {
                        alert(data.message);
                    }
                });
            });
            itemsList.appendChild(li);
        });
    }
});

document.getElementById('close-shop').addEventListener('click', () => {
    fetch(`https://lum-core/closeShop`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' }
    }).then(() => {
        document.getElementById('shop').style.display = 'none';
    });
});

// ui/ui.js
window.addEventListener('message', function(event) {
    if (event.data.action === 'openHouseMenu') {
        document.getElementById('house-menu').style.display = 'block';
        document.getElementById('house-label').innerText = event.data.house.label;
        document.getElementById('house-price').innerText = `Preço: $${event.data.house.price}`;
    }
});

document.getElementById('buy-house').addEventListener('click', () => {
    fetch(`https://lum-core/buyHouse`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' }
    }).then(resp => resp.json()).then(data => {
        if (data.success) {
            alert(data.message);
        } else {
            alert(data.message);
        }
    });
});

document.getElementById('sell-house').addEventListener('click', () => {
    fetch(`https://lum-core/sellHouse`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' }
    }).then(resp => resp.json()).then(data => {
        if (data.success) {
            alert(data.message);
        } else {
            alert(data.message);
        }
    });
});

document.getElementById('close-house-menu').addEventListener('click', () => {
    fetch(`https://lum-core/closeHouseMenu`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' }
    }).then(() => {
        document.getElementById('house-menu').style.display = 'none';
    });
});

// ui/ui.js
window.addEventListener('message', function(event) {
    if (event.data.action === 'openVehicleMenu') {
        document.getElementById('vehicle-menu').style.display = 'block';
        const vehicleList = document.getElementById('vehicle-list');
        vehicleList.innerHTML = '';
        event.data.vehicles.forEach(vehicle => {
            const li = document.createElement('li');
            li.innerText = `${vehicle.model} - ${vehicle.plate}`;
            li.addEventListener('click', () => {
                fetch(`https://lum-core/spawnVehicle`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ plate: vehicle.plate })
                }).then(resp => resp.json()).then(data => {
                    if (data.success) {
                        alert(data.message);
                    } else {
                        alert(data.message);
                    }
                });
            });
            vehicleList.appendChild(li);
        });
    }
});

document.getElementById('close-vehicle-menu').addEventListener('click', () => {
    fetch(`https://lum-core/closeVehicleMenu`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' }
    }).then(() => {
        document.getElementById('vehicle-menu').style.display = 'none';
    });
});