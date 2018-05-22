
export class PagerClass {
    
    getPager(totalItems: number, currentPage: number = 1, pageSize: number = 5){
        let totalPages = Math.round(Math.ceil(totalItems / pageSize ));

        let totalViewPage = 5
        let startPage : number, endPage : number;

        if(totalPages <= totalViewPage){
            startPage = 1;
            endPage = totalPages;

        } else {

            if( currentPage <= Math.round(Math.ceil(totalViewPage/2))){
                startPage = 1;
                endPage = totalViewPage;
            } else if( currentPage + totalViewPage/2 >= totalPages ){
                startPage = Math.round(totalPages - (totalViewPage - 1));
                endPage = totalPages;
            } else {
                startPage = Math.round(currentPage - totalViewPage/2);
                endPage = Math.round(currentPage + totalViewPage/2);
            }

        }
        // calculate start and end item indexes
        // let startIndex = (currentPage - 1) * pageSize;
        // let endIndex = Math.min(startIndex + pageSize - 1, totalItems - 1);

        var pages = [];
        for(var i = startPage; i <= endPage ;i++){
            pages.push(i);
        }
        return {
            totalItems: totalItems,
            currentPage: currentPage,
            pageSize: pageSize,
            totalPages: totalPages,
            startPage: startPage,
            endPage: endPage,
            pages: pages
        };


    }

}