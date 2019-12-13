# (C) 1992-2017 Intel Corporation.                            
# Intel, the Intel logo, Intel, MegaCore, NIOS II, Quartus and TalkBack words    
# and logos are trademarks of Intel Corporation or its subsidiaries in the U.S.  
# and/or other countries. Other marks and brands may be claimed as the property  
# of others. See Trademarks on intel.com for full list of Intel trademarks or    
# the Trademarks & Brands Names Database (if Intel) or See www.Intel.com/legal (if Altera) 
# Your use of Intel Corporation's design tools, logic functions and other        
# software and tools, and its AMPP partner logic functions, and any output       
# files any of the foregoing (including device programming or simulation         
# files), and any associated documentation or information are expressly subject  
# to the terms and conditions of the Altera Program License Subscription         
# Agreement, Intel MegaCore Function License Agreement, or other applicable      
# license agreement, including, without limitation, that your use is for the     
# sole purpose of programming logic devices manufactured by Intel and sold by    
# Intel or its authorized distributors.  Please refer to the applicable          
# agreement for further details.                                                 

source "$::env(INTELFPGAOCLSDKROOT)/ip/board/bsp/helpers.tcl"

proc qar_ip_files {{base_qar "base.qar"}} {
  set list_qar "tmp_qar_list"
  set list_handle [open $list_qar w]
  close $list_handle
  # create the list
  create_qar_list $list_qar dual_port_splitter
  create_qar_list $list_qar acl_kernel_interface_soc_pr
  create_qar_list $list_qar acl_ddr4_a10_core
  create_qar_list $list_qar acl_ddr4_a10
  create_qar_list $list_qar board
  create_qar_list $list_qar ip/dual_port_splitter
  create_qar_list $list_qar ip/acl_kernel_interface_soc_pr
  create_qar_list $list_qar ip/acl_ddr4_a10
  create_qar_list $list_qar ip/acl_ddr4_a10_core
  create_qar_list $list_qar ip/board/

  # add individual files
  set list_handle [open $list_qar a+]
  set list_in "opencl_bsp_ip.qsf base.qdb base.sdc pr_base.id"
  foreach line $list_in {
    puts $list_handle $line
  }
  close $list_handle
  qexec "quartus_sh --archive -input $list_qar -output $base_qar"
}

proc unqar_ip_files {{base_qar "base.qar"} {result_dir "."}} {
  qexec "quartus_sh --restore -output $result_dir $base_qar"
  file delete -force opencl_bsp_ip.qpf
}
