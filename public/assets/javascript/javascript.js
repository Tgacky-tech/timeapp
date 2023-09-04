const main = document.querySelectorAll(".main_menu");
const item = Array.prototype.slice.call(main, 0);

const categoryMenu = document.querySelector("#category-menu")
const categoryName = document.querySelector(".category-name")

categoryMenu.addEventListener("click", function() {
    categoryName.classList.toggle("incategory-name")
});

const newCategory = document.querySelector("#new-category")
const categoryForm = document.querySelector(".category-form")

newCategory.addEventListener("click", function() {
    categoryForm.classList.toggle("incategory-form")
})

const categories = document.querySelectorAll(".category-item")

categories.forEach(function(category) {
    category.addEventListener("click", function(e) {
        console.log(e.target.textContent.trim())
        console.log(e.target.dataset.id)

        const categorySelector = document.querySelector("#categoryselector")
        const nowSelected = document.querySelector("#now-selected")

        categorySelector.value = e.target.dataset
        nowSelected.textContent = e.target.textContent
    })
})

function tododetail1() {
    var detailContainer = document.getElementById('detailContainer1');
    if (detailContainer.style.display === 'block') {
        detailContainer.style.display = 'none';
    } else {
        detailContainer.style.display = 'block';
    }
}

function toggleForm1() {
    var formContainer = document.getElementById('formContainer1');
    if (formContainer.style.display === 'block') {
        formContainer.style.display = 'none';
    } else {
        formContainer.style.display = 'block';
    }
}

function toggleForm2() {
    var formContainer = document.getElementById('formContainer2');
    if (formContainer.style.display === 'block') {
        formContainer.style.display = 'none';
    } else {
        formContainer.style.display = 'block';
    }
}

function toggleForm3() {
    var formContainer = document.getElementById('formContainer3');
    if (formContainer.style.display === 'block') {
        formContainer.style.display = 'none';
    } else {
        formContainer.style.display = 'block';
    }
}

function toggleForm4() {
    var formContainer = document.getElementById('formContainer4');
    if (formContainer.style.display === 'block') {
        formContainer.style.display = 'none';
    } else {
        formContainer.style.display = 'block';
    }
}

function toggleForm5() {
    var formContainer = document.getElementById('formContainer5');
    if (formContainer.style.display === 'block') {
        formContainer.style.display = 'none';
    } else {
        formContainer.style.display = 'block';
    }
}

function toggleForm6() {
    var formContainer = document.getElementById('formContainer6');
    if (formContainer.style.display === 'block') {
        formContainer.style.display = 'none';
    } else {
        formContainer.style.display = 'block';
    }
}

function submitForm() {
    document.getElementById('formContainer').style.display = 'none';
}


