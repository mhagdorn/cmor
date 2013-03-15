check_PROGRAMS = cipcc_test_code ctest_grid ctest_lots_of_variables $(fortran_tests)
TESTS = $(patsubst %,%.sh,$(check_PROGRAMS)) $(patsubst %,%.sh,$(python_tests))

CLEANFILES = *.mod $(TESTS) $(subst sh,log,$(TESTS))
EXTRA_DIST = reader_2D_3D.f90 runner.sh \
             alejandro.txt alejandro_1.txt alejandro_2.txt tas_3D_noreorder.input \
             3D_txy.input 3D_txy_split_lon.input 3D_xty_split_lon.input \
             tas_mytest_3d_i.input noinput tas_mytest_noreorder.asc tas_mytest_3d_i.asc \
             ta_4D_r.asc tas_harvardf.txt CMIP5_cf3hr_0.txt CMIP5_cf3hr_1.txt \
             tas_mytest_reorder.asc tas_mytest_reorder_split_lon.asc CMIP5_Amons \
             CMIP5_cf3hr.txt tas_3D_xty_-180_180.asc

if BUILD_FORTRAN
fortran_tests = test1 test2 test3 test4 test_any_from_asc test_any_from_asc_d \
                karls_test main_prog test_any_from_asc_i mytest_4d_r \
                rewrite_harvardf_data test_3h test_dimensionless \
                test_fortran_example_00 test_fortran_example_01 test_station_data \
                test_cmor_grid_alejandro test_cmor_grid_time_varying test_region \
                test_sigma test_singleton mytest_4d_r_big_array mytest_4d_d_big_array_2 \
                mytest_4d_d_big_array_3 mytest_4d_d_big_array_4 mytest_4d_d_big_array_5 \
                climatology_test_code test_lots_of_variables test_shrt_exp_nm_set_att_initi \
                test_sophie ipcc_test_code
endif


if BUILD_PYTHON
if LARGE_TESTS
big_python_tests = test_python_2Gb_file.py test_python_2Gb_slice.py
endif

python_tests = test_python_direct_calls.py test_python_user_interface_00.py \
               test_python_user_interface_01.py test_python_user_interface_03.py \
               test_python_common.py cmor_speed_and_compression.py \
               cmor_speed_and_compression_01.py test_compression.py \
               test_python_appending.py test_python_bounds_request.py \
               test_python_new_tables.py test_python_jamie.py test_python_jamie_2.py \
               test_python_jamie_3.py test_python_jamie_4.py test_python_jamie_6.py \
               test_python_jamie_7.py test_python_jamie_8.py test_python_memory_check.py \
               test_python_open_close_cmor_multiple.py test_python_jamie_7.py \
               test_python_joerg_1.py test_python_joerg_2.py test_python_joerg_3.py \
               test_python_joerg_5.py test_python_joerg_6.py test_python_joerg_7.py \
               test_python_joerg_8.py test_python_joerg_10.py test_python_joerg_11.py \
               test_python_joerg_12.py test_python_YYYMMDDHH_exp_fmt.py \
               test_python_region.py jamie_hybrid_height.py jamie_positive.py \
               test_python_1D_var.py test_python_3hr.py test_python_YYYMMDDHH_exp_fmt.py \
               test_python_cfmip_site_axis_test.py test_python_fx.py \
               test_python_grid_and_ocn_sigma.py test_python_jamie_site_surface.py \
               test_python_max_variables.py test_python_max_variables_2.py \
               test_python_reverted_lats.py $(big_python_tests)
endif 

%.py.sh:	%.py
	@sed -e 's|@name[@]|$<|g'  pyrunner.sh > $@
	@chmod a+x $@

%.sh:	%
	@sed -e 's|@name[@]|$<|g' -e 's|@inputs[@]|$($<_INPUT)|g' runner.sh > $@
	@chmod a+x $@

fldadd = ../Src/libcmorf.la
cldadd = ../Src/libcmor.la
AM_FCFLAGS = -I../Src
AM_CPPFLAGS = -I$(top_srcdir)/include -I$(top_srcdir)/include/cdTime $(UDUNITS2_CPPFLAGS)

cipcc_test_code_SOURCES = cipcc_test_code.c reader_2D_3D.h
cipcc_test_code_LDADD = $(cldadd)
cipcc_test_code_INPUT = noinput

ctest_grid_SOURCES = ctest_grid.c reader_2D_3D.h
ctest_grid_LDADD = $(cldadd)
ctest_grid_INPUT = noinput

ctest_lots_of_variables_SOURCES = ctest_lots_of_variables.c reader_2D_3D.h
ctest_lots_of_variables_LDADD = $(cldadd)
ctest_lots_of_variables_INPUT = noinput

test_any_from_asc_SOURCES = test_any_from_asc.f90
test_any_from_asc_LDADD = $(fldadd)
test_any_from_asc_INPUT = tas_3D_noreorder.input 3D_txy.input 3D_txy_split_lon.input 3D_xty_split_lon.input

test_any_from_asc_d_SOURCES = test_any_from_asc.f90
test_any_from_asc_d_LDADD = $(fldadd)
test_any_from_asc_d_INPUT = tas_3D_noreorder.input 3D_txy.input 3D_txy_split_lon.input 3D_xty_split_lon.input

karls_test_SOURCES = karls_test.f90
karls_test_LDADD = $(fldadd)
karls_test_INPUT = noinput

test1_SOURCES = test1.f90
test1_LDADD = $(fldadd)
test1_INPUT = noinput

test2_SOURCES = test2.f90
test2_LDADD = $(fldadd)
test2_INPUT = noinput

test3_SOURCES = test3.f90
test3_LDADD = $(fldadd)
test3_INPUT = noinput

test4_SOURCES = test4.f90
test4_LDADD = $(fldadd)
test4_INPUT = noinput

main_prog_SOURCES = main_prog.f90
main_prog_LDADD = $(fldadd)
main_prog_INPUT = noinput

test_any_from_asc_i_SOURCES = test_any_from_asc_i.f90
test_any_from_asc_i_LDADD = $(fldadd)
test_any_from_asc_i_INPUT = tas_mytest_3d_i.input

mytest_4d_r_SOURCES = mytest_4d_r.f90
mytest_4d_r_LDADD = $(fldadd)
mytest_4d_r_INPUT = noinput

rewrite_harvardf_data_SOURCES = rewrite_harvardf_data.f90
rewrite_harvardf_data_LDADD = $(fldadd)
rewrite_harvardf_data_INPUT = noinput

test_3h_SOURCES = test_3h.f90
test_3h_LDADD = $(fldadd)
test_3h_INPUT = noinput

test_dimensionless_SOURCES = test_dimensionless.f90
test_dimensionless_LDADD = $(fldadd)
test_dimensionless_INPUT = noinput

test_fortran_example_00_SOURCES = test_fortran_example_00.f90
test_fortran_example_00_LDADD = $(fldadd)
test_fortran_example_00_INPUT = noinput

test_fortran_example_01_SOURCES = test_fortran_example_00.f90
test_fortran_example_01_LDADD = $(fldadd)
test_fortran_example_01_INPUT = noinput

test_station_data_SOURCES = test_station_data.f90
test_station_data_LDADD = $(fldadd)
test_station_data_INPUT = noinput

test_cmor_grid_alejandro_SOURCES = test_cmor_grid_alejandro.f90
test_cmor_grid_alejandro_LDADD = $(fldadd)
test_cmor_grid_alejandro_INPUT = alejandro.txt alejandro_1.txt alejandro_2.txt

test_cmor_grid_time_varying_SOURCES = test_cmor_grid_time_varying.f90
test_cmor_grid_time_varying_LDADD = $(fldadd)
test_cmor_grid_time_varying_INPUT = alejandro.txt alejandro_1.txt

test_region_SOURCES = test_region.f90
test_region_LDADD = $(fldadd)
test_region_INPUT = noinput

test_sigma_SOURCES = test_sigma.f90
test_sigma_LDADD = $(fldadd)
test_sigma_INPUT = noinput

test_singleton_SOURCES = test_singleton.f90
test_singleton_LDADD = $(fldadd)
test_singleton_INPUT = noinput

mytest_4d_r_big_array_SOURCES = mytest_4d_r_big_array.f90
mytest_4d_r_big_array_LDADD = $(fldadd)
mytest_4d_r_big_array_INPUT = noinput

mytest_4d_d_big_array_2_SOURCES = mytest_4d_d_big_array_2.f90
mytest_4d_d_big_array_2_LDADD = $(fldadd)
mytest_4d_d_big_array_2_INPUT = noinput

mytest_4d_d_big_array_3_SOURCES = mytest_4d_d_big_array_3.f90
mytest_4d_d_big_array_3_LDADD = $(fldadd)
mytest_4d_d_big_array_3_INPUT = noinput

mytest_4d_d_big_array_4_SOURCES = mytest_4d_d_big_array_4.f90
mytest_4d_d_big_array_4_LDADD = $(fldadd)
mytest_4d_d_big_array_4_INPUT = noinput

mytest_4d_d_big_array_5_SOURCES = mytest_4d_d_big_array_5.f90
mytest_4d_d_big_array_5_LDADD = $(fldadd)
mytest_4d_d_big_array_5_INPUT = noinput

climatology_test_code_SOURCES = climatology_test_code.f90
climatology_test_code_LDADD = $(fldadd)
climatology_test_code_INPUT = noinput

test_lots_of_variables_SOURCES = test_lots_of_variables.f90
test_lots_of_variables_LDADD = $(fldadd)
test_lots_of_variables_INPUT = noinput

test_shrt_exp_nm_set_att_initi_SOURCES = test_shrt_exp_nm_set_att_initi.f90
test_shrt_exp_nm_set_att_initi_LDADD = $(fldadd)
test_shrt_exp_nm_set_att_initi_INPUT = noinput

test_sophie_SOURCES = test_sophie.f90
test_sophie_LDADD = $(fldadd)
test_sophie_INPUT = noinput

ipcc_test_code_SOURCES = ipcc_test_code.f90
ipcc_test_code_LDADD = $(fldadd)
ipcc_test_code_INPUT = noinput
