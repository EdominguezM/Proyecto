
window.addEventListener('load', () =>{

  let navbar = document.getElementById('nav');
  navbar.addEventListener('mouseover', function() {
    navbar.style.backgroundColor = '#0a84f7';
  })
 
  navbar.addEventListener('mouseout', function() {
    navbar.style.backgroundColor = '#0c5e94';
  })
})