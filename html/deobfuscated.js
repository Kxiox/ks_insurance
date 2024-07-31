window.addEventListener('message', (event) => {
    if (event.data.type === 'open') {
        changeColor(event.data.color, event.data.background)
        setButtons(event.data.insurances)
        setPrices(event.data.prices) 
        setInsurances(event.data.enabled_insurances)
        let slideIndex = 0;
        showSlides(slideIndex);
        $('body').fadeIn();
        $('body').css('display', 'flex');    
    } if (event.data.type === 'close') {
        $('body').fadeOut();
    }
});

function setButtons(insurances) {
    if (insurances[0].car == 1) {
        $('#car').removeClass('btn_anmelden').addClass('btn_abmelden');
        $('#car').html('Abmelden');
    }

    if (insurances[0].krank == 1) {
        $('#krank').removeClass('btn_anmelden').addClass('btn_abmelden');
        $('#krank').html('Abmelden');
    }

    if (insurances[0].haft == 1) {
        $('#haft').removeClass('btn_anmelden').addClass('btn_abmelden');
        $('#haft').html('Abmelden');
    }

    if (insurances[0].wohn == 1) {
        $('#wohn').removeClass('btn_anmelden').addClass('btn_abmelden');
        $('#wohn').html('Abmelden');
    }

    if (insurances[0].beruf == 1) {
        $('#beruf').removeClass('btn_anmelden').addClass('btn_abmelden');
        $('#beruf').html('Abmelden');
    }

    if (insurances[0].recht == 1) {
        $('#recht').removeClass('btn_anmelden').addClass('btn_abmelden');
        $('#recht').html('Abmelden');
    }
}

function changeColor(color, background) {
    
    $(':root').css('--main-color', color);

    $('body').css('background', background);

}

function close() {
    $('body').fadeOut();

    fetch(`https://${GetParentResourceName()}/close`)
}

let slideIndex = 0;
showSlides(slideIndex);

function nextSlide() {
    slideIndex++;
    showSlides(slideIndex);
}

function prevSlide() {
    slideIndex--;
    showSlides(slideIndex);
}

function showSlides(index) {
    const slides = document.querySelectorAll('.card');
    if (index >= slides.length) {
        slideIndex = 0;
    }
    if (index < 0) {
        slideIndex = slides.length - 1;
    }
    slides.forEach((slide, i) => {
        slide.style.transform = `translateX(${(i - slideIndex) * 100}%)`;
    });
}

function setPrices(prices) {
    $('#price_car').html(prices.car + prices.currency);
    $('#price_krank').html(prices.krank + prices.currency);
    $('#price_haft').html(prices.haft + prices.currency);
    $('#price_wohn').html(prices.wohn + prices.currency);
    $('#price_beruf').html(prices.beruf + prices.currency);
    $('#price_recht').html(prices.recht + prices.currency);
}

function triggerButton(type, id) {
    if (type.includes('btn_anmelden')) {
        $('#' + id).addClass('btn_abmelden').removeClass('btn_anmelden');
        $('#' + id).html('Abmelden');

        fetch(`https://${GetParentResourceName()}/setInsurance`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                type: type,
                id: id
            })
        }).then(resp => resp.json()).then(resp => console.log(resp));
    } else if (type.includes('btn_abmelden')) {
        $('#' + id).addClass('btn_anmelden').removeClass('btn_abmelden');
        $('#' + id).html('Anmelden');

        fetch(`https://${GetParentResourceName()}/setInsurance`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({
                type: type,
                id: id
            })
        }).then(resp => resp.json()).then(resp => console.log(resp));
    }
}

function setInsurances(insurances) {
    if (insurances.car == false) {
        $('#card_car').remove();
    }

    if (insurances.krank == false) {
        $('#card_krank').remove();
    }

    if (insurances.haft == false) {
        $('#card_haft').remove();
    }

    if (insurances.wohn == false) {
        $('#card_wohn').remove();
    }

    if (insurances.beruf == false) {
        $('#card_beruf').remove();
    }

    if (insurances.recht == false) {
        $('#card_recht').remove();
    }
}

$('.btn').click(function (e) { 
    close()
});

$('#car').click(function (e) { 
    triggerButton($('#car').attr('class'), 'car');
});

$('#krank').click(function (e) { 
    triggerButton($('#krank').attr('class'), 'krank');
});

$('#haft').click(function (e) { 
    triggerButton($('#haft').attr('class'), 'haft');  
});

$('#wohn').click(function (e) { 
    triggerButton($('#wohn').attr('class'), 'wohn');  
});

$('#beruf').click(function (e) { 
    triggerButton($('#beruf').attr('class'), 'beruf');  
});

$('#recht').click(function (e) { 
    triggerButton($('#recht').attr('class'), 'recht');  
});
