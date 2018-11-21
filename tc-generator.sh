#!/bin/bash

cat <<EOF

tr raster-clip-wrapper.sh {
    site condor_pool {
        type "STAGEABLE"
        pfn "file://$PWD/raster-clip-wrapper.sh"
    }
}

tr river-depth-wrapper.sh {
    site condor_pool {
        type "STAGEABLE"
        pfn "file://$PWD/river-depth-wrapper.sh"
    }
}


EOF

