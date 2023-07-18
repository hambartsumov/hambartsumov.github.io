function scrollTo(hash)
{
  location.hash = "#" + hash
}

let list = document.querySelectorAll('.right-centered > h1, .right-centered > h2, .right-centered > h3,\
.right-centered > h5, .right-centered > h6, .right-centered > h7');
list.forEach((element) => {
    element.setAttribute('id', element.innerHTML);
    let li = document.getElementsByClassName('menu-itself')[0].appendChild(document.createElement('li'));
    let a = document.createElement('a');
    a.setAttribute('href', "#" + element.innerHTML);
    a.innerHTML =  element.innerHTML;
    li.appendChild(a);
    
});