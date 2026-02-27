(function() {
  /**
   * 페이지를 아래로 스크롤할 때 body에 scrolled 클래스를 추가
   */
  function toggleScrolled() {
    const selectBody = document.querySelector('body');
    const selectHeader = document.querySelector('#header');
    if (!selectHeader.classList.contains('scroll-up-sticky') && !selectHeader.classList.contains('sticky-top') && !selectHeader.classList.contains('fixed-top')) return;
    window.scrollY > 100 ? selectBody.classList.add('scrolled') : selectBody.classList.remove('scrolled');
  }

  document.addEventListener('scroll', toggleScrolled);
  window.addEventListener('load', toggleScrolled);
	
  /**
   * Preloader : 로딩중일 때 출력 
   */
  const preloader = document.querySelector('#preloader');
  /*
  if (preloader) {
    window.addEventListener('load', () => {
      preloader.remove();
    });
  }
  */
  const isHidden = el => {
  	 const styles = window.getComputedStyle(el);
  	 return styles.display === 'none' || styles.visibility === 'hidden';
  };  
  if (! isHidden(preloader)) {
    window.addEventListener('load', () => {
      preloader.style.display = 'none';
    });
  }
  
  /**
   * Scroll top button
   */
  let scrollTop = document.querySelector('.scroll-top');
  if(scrollTop) {
	  function toggleScrollTop() {
	    if (scrollTop) {
	      window.scrollY > 100 ? scrollTop.classList.add('active') : scrollTop.classList.remove('active');
	    }
	  }
	  scrollTop.addEventListener('click', (e) => {
	    e.preventDefault();
	    window.scrollTo({
	      top: 0,
	      behavior: 'smooth'
	    });
	  });
	
	  window.addEventListener('load', toggleScrollTop);
	  document.addEventListener('scroll', toggleScrollTop);
  }
  
  /**
   * Animation on scroll function and init : AOS 초기화
   */
  function aosInit() {
    AOS.init({
      duration: 600,
      easing: 'ease-in-out',
      once: true,
      mirror: false
    });
  }
  window.addEventListener('load', aosInit);
})();

