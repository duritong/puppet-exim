class exim::debian inherits exim::base {
    Package['exim']{
      name => 'exim-base',
    }
    
    include exim::debian::light
}