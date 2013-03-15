from test_python_common import * # common subroutines

import cmor._cmor
import os

pth = os.path.split(os.path.realpath(os.curdir))
if pth[-1]=='Test':
    ipth = opth = '.'
else:
    ipth = opth = 'Test'


myaxes=numpy.zeros(9,dtype='i')
myaxes2=numpy.zeros(9,dtype='i')
myvars=numpy.zeros(9,dtype='i')


cmor.setup(inpath=ipth,set_verbosity=cmor.CMOR_NORMAL, netcdf_file_action = cmor.CMOR_REPLACE, exit_control = cmor.CMOR_EXIT_ON_MAJOR);
cmor.dataset(
    outpath = opth,
    experiment_id = "historical",
    institution = "GICC (Generic International Climate Center, Geneva, Switzerland)",
    source = "GICCM1 2002: atmosphere:  GICAM3 (gicam_0_brnchT_itea_2, T63L32); ocean: MOM (mom3_ver_3.5.2, 2x3L15); sea ice: GISIM4; land: GILSM2.5",
    calendar = "standard",
    realization = 1,
    contact = "Rusty Koder (koder@middle_earth.net)",
    history = "Output from archive/giccm_03_std_2xCO2_2256.",
    comment = "Equilibrium reached after 30-year spin-up after which data were output starting with nominal date of January 2030",
    references = "Model described by Koder and Tolkien (J. Geophys. Res., 2001, 576-591).  Also see http://www.GICC.su/giccm/doc/index.html  2XCO2 simulation described in Dorkey et al. '(Clim. Dyn., 2003, 323-357.)",
    leap_year=0,
    leap_month=0,
    month_lengths=None,
    model_id="GICCM1",
    forcing="Ant, Nat",
    institute_id="pcmdi",
    parent_experiment_rip="r1i1p1",
    parent_experiment_id="piControl",branch_time=18336.33)

#cmor.set_cur_dataset_attribute("parent_experiment_rip","r1i1p1")

tables=[]
a = cmor.load_table("../Tables/CMIP5_grids")
tables.append(a)
tables.append(cmor.load_table("../Tables/CMIP5_Omon"))
print 'Tables ids:',tables

cmor.set_table(tables[0])

x,y,lon_coords,lat_coords,lon_vertices,lat_vertices = gen_irreg_grid(lon,lat)



myaxes[0] = cmor.axis(table_entry = 'y', 
                      units = 'm', 
                      coord_vals = y)
myaxes[1] = cmor.axis(table_entry = 'x', 
                      units = 'm', 
                      coord_vals = x)

grid_id = cmor.grid(axis_ids = myaxes[:2], 
                    latitude = lat_coords, 
                    longitude = lon_coords, 
                    latitude_vertices = lat_vertices, 
                    longitude_vertices = lon_vertices)
print 'got grid_id:',grid_id
myaxes[2] = grid_id

## mapnm = 'lambert_conformal_conic'
## params = [ "standard_parallel1",
##            "longitude_of_central_meridian","latitude_of_projection_origin",
##            "false_easting","false_northing","standard_parallel2" ]
## punits = ["","","","","","" ]
## pvalues = [-20.,175.,13.,8.,0.,20. ]
## cmor.set_grid_mapping(grid_id=myaxes[2],
##                       mapping_name = mapnm,
##                       parameter_names = params,
##                       parameter_values = pvalues,
##                       parameter_units = punits)

cmor.set_table(tables[1])
myaxes[3] = cmor.axis(table_entry = 'time',
                      units = 'months since 1980')

pass_axes = [myaxes[3],myaxes[2]]

print 'ok going to cmorvar'
myvars[0] = cmor.variable( table_entry = 'calc',
                           units = 'mol m-3',
                           axis_ids = pass_axes,
                           original_name = 'yep',
                           history = 'no history',
                           comment = 'no future'
                           )

ntimes=2
for i in range(0,ntimes,2):
    data2d_1 = read_2d_input_files(i,   varin2d[0], lat,lon)
    data2d_2 = read_2d_input_files(i+1, varin2d[0], lat,lon)
    data2d=numpy.array((data2d_1,data2d_2))
    print 'writing time: ',i,data2d.shape,data2d
    print Time[i:i+2],bnds_time[2*i:2*i+4]    
    cmor.write(myvars[0],data2d,2,time_vals=numpy.arange(i,i+2),time_bnds=numpy.arange(i,i+3))
cmor.close()
