/* global $, Stripe */
// 1. Document Ready
$(document).on('turbolinks.load', function(){c
  var theForm = $('#pro_form'); // Giving the Pro Form and variable name theForm by referencing the id we gave it. #pro_form CSS   
  var submitBtn = $('#form-submit-btn');
  
  // 2. Set Stripe Public Key
  Stripe.setPublishableKey( $('meta[name="stripe-key"]').attr('content') );)
  
    // 3. When User Clicks the Form Submit Btn.  
    submitBtn.click(function(event){
      
    // 4. Prevent Default Submission Behavior. We are holding off on Sending information to Stripe
      event.preventDefault();
      
    // 5. Collect the Credit Card Fields (Remember we are identifying the fields with the # - ids CSS)
      var ccNum    = $('#card_number').val(),
          cvcNum   = $('#card_code').val(),
          expMonth = $('#card_month').val(),
          expYear  = $('#card_year').val();
          
    // 6. Send the Card Information on to Stripe.
    
      Stripe.createToken({  // Creating the Object function for the fields {()}
      number: ccNum,
      cvc: cvcNum,
      exp_month: expMonth,
      exp_year: expYear
    }, stripeResponseHandler); // stripeResponseHandler is the Callback Function
  });
  
  });
    // 7. Stripe will Return back with a Card Token
    
    // 8. Inject Card Token as Hidden Field into the Form.
    
    // 9. Submit Form to the Rails Application. 

)};


