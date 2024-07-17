window.addEventListener('message', (event) => {
    if (event.data.type === 'open') {
        changeColor(event.data.color, event.data.background)
        setButtons(event.data.insurances)        
        $('body').fadeIn();
        $('body').css('display', 'flex');
    } if (event.data.type === 'close') {
        $('body').fadeOut();
    }
});

function setButtons(insurances) {
    console.log(insurances)
    if (insurances[0].kfz == 1) {
        $('#car').removeClass('btn_anmelden').addClass('btn_abmelden');
        $('#car').html('Abmelden');
    }

    if (insurances[0].health == 1) {
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

$('.btn').click(function (e) { 
    close()
});
