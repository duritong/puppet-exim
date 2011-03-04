class exim::debian inherits exim::base {
    Package['exim']{
      name => 'exim4-base',
    }
    
    include exim::debian::light
}