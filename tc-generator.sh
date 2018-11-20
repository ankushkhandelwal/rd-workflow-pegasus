#!/bin/bash

cat <<EOF

tr prediction-wrapper.sh {
    site condor_pool {
        type "STAGEABLE"
        pfn "file://$PWD/prediction-wrapper-bk.sh"
    }
}


tr prepare-buildings.sh {
    site condor_pool {
        type "STAGEABLE"
        pfn "file://$PWD/prepare-buildings.sh"
    }
}


tr select-image-partitions.sh {
    site condor_pool_small {
        type "STAGEABLE"
        pfn "file://$PWD/select-image-partitions.sh"
    }
}

tr prepare-job-metadata.sh {
    site condor_pool_small {
        type "STAGEABLE"
        pfn "file://$PWD/prepare-job-metadata.sh"
    }
}

tr polygon-wrapper.sh {
    site condor_pool_small {
        type "STAGEABLE"
        pfn "file://$PWD/polygon-wrapper.sh"
    }
}

tr merge-wrapper.sh {
    site condor_pool {
        type "STAGEABLE"
       	pfn "file://$PWD/merge-wrapper.sh"
    }
}

tr merge-wrapper-recursive.sh {
    site condor_pool {
        type "STAGEABLE"
       	pfn "file://$PWD/merge-wrapper-recursive.sh"
    }
}

EOF

