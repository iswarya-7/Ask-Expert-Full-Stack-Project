


// Add this at the beginning of your script
console.log("Hello World....");

document.addEventListener("DOMContentLoaded", function () {
    // Make sure modal is hidden on page load
    document.getElementById("profileModal").style.display = "none";
});


// user drop down
const User = document.getElementById('user_icon');
const Drop = document.getElementById('user_drop');

User.addEventListener("click", function (event) {
    event.stopPropagation(); // Prevents immediate closing
    Drop.classList.toggle("show");
});

// Close dropdown when clicking outside
window.addEventListener("click", function (event) {
    if (!User.contains(event.target) && !Drop.contains(event.target)) {
        Drop.classList.remove("show");
    }
});




// profile page
function openProfileModal() {
    var modal = document.getElementById("profileModal");
    modal.style.display = "flex";
    // Set alignment properties when showing
    modal.style.alignItems = "center";
    modal.style.justifyContent = "center";
}

function closeProfileModal() {
    document.getElementById("profileModal").style.display = "none";
}

// Close modal when clicking outside
window.onclick = function (event) {
    let modal = document.getElementById("profileModal");
    if (event.target === modal) {
        modal.style.display = "none";
    }
};



// add question

// select qn and plus icon
const addQuestionButton = document.querySelector('.plus');
const questionForm = document.querySelector('.add_qn');
const livePreview = document.querySelector(".live_preview")


// toggle form for open and close
function addquestion() {
    console.log("Add question is clicked....");
    questionForm.classList.toggle("hidden");

    // Save visibility state in localStorage
    localStorage.setItem("formVisible", !questionForm.classList.contains("hidden"));
}

// to view the data in preview
function selectcategory(category) {
    document.getElementById('preview_category').innerHTML = category;
}

function selectspecialist(specialistn) {
    document.getElementById('preview_specialistname').innerHTML = specialistn;
}

function user_question() {
    document.getElementById('preview_userqn').innerHTML = document.getElementById('qn').value;
}


// Check and restore form visibility after refresh
function checkFormVisiblity() {
    if (localStorage.getItem("formVisible") === "true") {
        questionForm.classList.remove("hidden");
    } else {
        questionForm.classList.add("hidden");
    }
}

// function to clear only entered when page reload
function clearDataOnfresh() {
    document.getElementById('preview_category').innerText = " ";
    document.getElementById('preview_specialistname').innerText = " ";
    document.getElementById('preview_userqn').innerText = " ";
}


// Run functions on page Load
document.addEventListener("DOMContentLoaded", function () {
    // your code here
    checkFormVisiblity();
    clearDataOnfresh();

});

function qnsubmit() {
    //   select all the input values
    var selected_Category = document.getElementById('preview_category').innerText;
    var selected_Specilaist = document.getElementById('preview_specialistname').innerText;
    var selected_userQn = document.getElementById('preview_userqn').innerText;
    var question_input = document.getElementById('qn').value;
    console.log(question_input);
    if (selected_Category === "" || selected_Specilaist === "" || selected_userQn === "") {
        alert(" Please select category, specialist & enter your question! ")
    } else {
        // to clear the input box details 
        // document.getElementById('preview_userqn').innerText = question_input;
        alert("✅Your question has been submitted successfully!");

        // Reset Form
        question_input = "";
        document.getElementById("preview_category").innerText = "None";
        document.getElementById("preview_specialistname").innerText = "None";
        document.getElementById("preview_userqn").innerText = "---";
    }



}



