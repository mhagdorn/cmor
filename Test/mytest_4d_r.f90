program main

  USE cmor_users_functions
  implicit none

  integer ncid

  type dims
     integer n
     character(256) name
     character(256) units
     double precision, DIMENSION(:), pointer :: values
     double precision, DIMENSION(:,:), pointer :: bounds     
     type(dims), pointer :: next
  end type dims
  character(256) filein
  type(dims), pointer :: mydims,current
  integer ndim,i,j,ntot,k,l
!  double precision, allocatable, dimension(:,:,:,:):: arrayin
  real, allocatable, dimension(:,:,:,:):: arrayin
  integer, dimension(7):: dimlength = (/ (1,i=1,7) /)
  integer, PARAMETER::verbosity = 2
  integer ierr
  integer, allocatable, dimension(:) :: myaxis
  integer myvar
  real amin,amax,mymiss
  double precision bt
  bt=0.
  print*, 'hi'
  filein='ta_4D_r.asc'
  open(unit=23,file=filein,form='formatted') 
  call allocate_dims(23,mydims,ndim,dimlength)
  allocate(myaxis(ndim))
  allocate(arrayin(dimlength(1),dimlength(2),dimlength(3),dimlength(4)))
  print*,'allocatedat:',shape(arrayin),dimlength(1),dimlength(2),dimlength(3),dimlength(4)
  current=>mydims
  ntot=1
  do i =1,ndim
     ntot=ntot*current%n
     current=>current%next
  enddo
  call read_ascii(23,mydims, ndim,ntot,arrayin)
!!$!! Ok here is the part where we define or variable/axis,etc... 
!!$!! Assuming that Karl's code is ok...
!!$
  print*,'CMOR SETUP'
!!$  
  ierr = cmor_setup(inpath='.',   &
       netcdf_file_action='replace',                                       &
       set_verbosity=1,                                                    &
       exit_control=1)
    
  print*,'CMOR DATASET'
  ierr = cmor_dataset(                                   &
       outpath='.',         &
       experiment_id='abrupt 4XCO2',           &
       institution=                                            &
       'GICC (Generic International Climate Center, ' //       &
       ' Geneva, Switzerland)',                                &
       source='GICCM1  2002(giccm_0_brnchT_itea_2, T63L32)',    &
       calendar='noleap',                                      &
       realization=1,                                          &
       history='Output from archive/giccm_03_std_2xCO2_2256.', &
       comment='Equilibrium reached after 30-year spin-up ' // &
       'after which data were output starting with nominal '// &
       'date of January 2030',                                 &
       references='Model described by Koder and Tolkien ' //   &
       '(J. Geophys. Res., 2001, 576-591).  Also ' //          &
       'see http://www.GICC.su/giccm/doc/index.html '  //      &
       ' 2XCO2 simulation described in Dorkey et al. '//       &
       '(Clim. Dyn., 2003, 323-357.)', &
       model_id="GICCM1",&
       forcing='TO',contact="Barry Bonds",institute_id="PCMDI",&
       parent_experiment_rip="N/A",parent_experiment_id="N/A",branch_time=bt)
  
  current=>mydims
  do i = 0,ndim-1
     print*,'CMOR AXIS',i,'AAAAAAA*************************************************************************'
     print*, 'Name:',trim(adjustl(current%name))
!!$     print*, current%units
!!$     print*, current%n,size(current%values)
!!$     print*, current%values(1:min(4,size(current%values)))
!!$     print*, current%bounds(1:2,1:min(4,size(current%values)))
     if (trim(adjustl(current%name)).eq.'time') then
        print*, 'time found'
     myaxis(ndim-i)=cmor_axis('../Tables/CMIP5_Amon', &
          table_entry=current%name,&
          units=current%units,&
          length=current%n,&
!!$          coord_vals=current%values,&
!!$          cell_bounds=current%bounds, &
          interval='1 month')
     else
     myaxis(ndim-i)=cmor_axis('../Tables/CMIP5_Amon', &
          table_entry=current%name,&
          units=current%units,&
          length=current%n,&
          coord_vals=current%values,&
          cell_bounds=current%bounds)
        print*, 'not time'
     endif
     current=>current%next
  enddo

  print*,'CMOR VARCMOR VARCMOR VARCMOR'

  mymiss=1.e20
  myvar=cmor_variable('../Tables/CMIP5_Amon',&
       'ta',&
       'K',&
       myaxis,&
       missing_value=mymiss)

!! figures out length of dimension other than time

  j=ntot/mydims%n
!!$  print*, '&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
!!$  print*,'before:', shape(arrayin),mydims%n
!!$  print*,'before:', shape(arrayin(:,i,:))
!!$  print*, 'time before:',mydims%next%values(i:i)
  current=>mydims%next%next
print*, 'values:',current%values
print*, 'bounds:',current%bounds
print*, 'N:',current%n
  ierr =  cmor_write( &
       myvar, &
       arrayin, &
       ntimes_passed = current%n, &
       time_vals     = current%values,  &
       time_bnds     = current%bounds &
       )
  ierr = cmor_close()

contains
  subroutine allocate_dims(file_id,mydims,ndim,dimlength)
    implicit none
    integer i,n,j,tmp,file_id
    integer, intent(inout)::ndim
    integer, intent(inout):: dimlength(7)
    type(dims) , pointer :: tmpdims,mydims
    read(file_id,'(i8)') ndim
!!$    allocate(dimlength(ndim))
    n=1
    allocate(mydims)
    tmpdims=>mydims
    do i = 1, ndim
       read(file_id,'(I8)') tmp
!!$print*,'allocatedat:',tmp
       dimlength(5-i)=tmp
       allocate(tmpdims%values(tmp))
       allocate(tmpdims%bounds(2,tmp))
       tmpdims%n=tmp
       allocate(tmpdims%next)
       tmpdims=>tmpdims%next
       n=n*tmp
    enddo
    deallocate(tmpdims)
  end subroutine allocate_dims
  
  subroutine read_ascii(file_unit,mydims,ndim,ntot,arrayin)
    implicit none
    type(dims), pointer::  mydims
!    double precision, dimension(:,:,:),intent(inout) :: arrayin
    real, dimension(:,:,:,:),intent(inout) :: arrayin
!    integer, dimension(ndim)
    type(dims), pointer ::  current
    integer, intent(in)::ndim,file_unit
    integer n,ntot,i,j,k,l,m
    
    current=>mydims
    ntot=1
    do i =1,ndim
       n=current%n
       ntot=ntot*n
       read(file_unit,'(A)') current%name
       print*, 'NAME is:',current%name,trim(adjustl(mydims%name))
       if (current%name.eq."pressure") current%name="plevs"
       read(file_unit,'(A)') current%units
       read(file_unit,*) (current%values(j),j=1,n)
       read(file_unit,*) ((current%bounds(j,k),j=1,2),k=1,n)
       print*, current%bounds(1,1),current%bounds(1,2)
       current=>current%next
    enddo
    read(file_unit,*) ((((arrayin(j,k,l,m),j=1,size(arrayin,1)),k=1,size(arrayin,2)),l=1,size(arrayin,3)),m=1,size(arrayin,4))
print* ,trim(adjustl(mydims%name))
  end subroutine read_ascii

end program main

