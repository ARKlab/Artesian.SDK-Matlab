classdef AuctionBid

    properties
        bidTimestamp
        bid
        offer
    end

    methods

        function obj = AuctionBid(bidTimestamp, bid, offer)
            obj.bidTimestamp = bidTimestamp;
            obj.bid = buildAuctionValues(bid);
            obj.offer = buildAuctionValues(offer);
        end

    end

end

function output = buildAuctionValues(input)
    output = {};

    for i = input
        row = {};
        row.price = i{1}{1};
        row.quantity = i{1}{2};

        output = [output, row];
    end

end
