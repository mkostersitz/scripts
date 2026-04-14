#!/usr/bin/env python3
"""
DNS TXT Record Verification Tool
Verifies that a DNS TXT record exists and matches the expected value.
Cross-platform: macOS, Windows, Linux
"""

import sys
import argparse
import dns.resolver
from typing import List, Tuple


def query_txt_record(record_name: str) -> List[str]:
    """
    Query DNS for TXT records of the given domain.
    
    Args:
        record_name: The DNS record name to query
        
    Returns:
        List of TXT record values as strings
        
    Raises:
        dns.resolver.NXDOMAIN: If the domain doesn't exist
        dns.resolver.NoAnswer: If no TXT records found
        dns.resolver.Timeout: If DNS query times out
    """
    resolver = dns.resolver.Resolver()
    resolver.timeout = 5
    resolver.lifetime = 10
    
    try:
        answers = resolver.resolve(record_name, 'TXT')
        txt_records = []
        
        for rdata in answers:
            # TXT records can have multiple strings, concatenate them
            txt_value = ''.join([s.decode('utf-8') if isinstance(s, bytes) else s 
                                for s in rdata.strings])
            txt_records.append(txt_value)
        
        return txt_records
    except dns.resolver.NXDOMAIN:
        raise Exception(f"Domain '{record_name}' does not exist")
    except dns.resolver.NoAnswer:
        raise Exception(f"No TXT records found for '{record_name}'")
    except dns.resolver.Timeout:
        raise Exception(f"DNS query timeout for '{record_name}'")
    except Exception as e:
        raise Exception(f"DNS query failed: {str(e)}")


def verify_txt_record(record_name: str, expected_value: str) -> Tuple[bool, str]:
    """
    Verify that a TXT record exists and matches the expected value.
    
    Args:
        record_name: The DNS record name to verify
        expected_value: The expected TXT record value
        
    Returns:
        Tuple of (success: bool, message: str)
    """
    try:
        txt_records = query_txt_record(record_name)
        
        if not txt_records:
            return False, f"No TXT records found for '{record_name}'"
        
        # Check if expected value matches any of the TXT records
        if expected_value in txt_records:
            if len(txt_records) == 1:
                return True, f"✓ TXT record verified successfully\n  Record: {record_name}\n  Value: {expected_value}"
            else:
                return True, f"✓ TXT record verified successfully (matched 1 of {len(txt_records)} records)\n  Record: {record_name}\n  Value: {expected_value}"
        else:
            msg = f"✗ TXT record value mismatch\n  Record: {record_name}\n  Expected: {expected_value}\n  Found:"
            for i, record in enumerate(txt_records, 1):
                msg += f"\n    [{i}] {record}"
            return False, msg
            
    except Exception as e:
        return False, f"✗ Verification failed: {str(e)}"


def main():
    """Main entry point for the CLI application."""
    parser = argparse.ArgumentParser(
        description='Verify DNS TXT record existence and value',
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog='''
Examples:
  %(prog)s example.com "v=spf1 include:_spf.google.com ~all"
  %(prog)s _dmarc.example.com "v=DMARC1; p=reject;"
  %(prog)s verification.example.com "google-site-verification=ABC123"
        '''
    )
    
    parser.add_argument(
        'record_name',
        help='DNS record name to verify (e.g., example.com or _dmarc.example.com)'
    )
    
    parser.add_argument(
        'expected_value',
        help='Expected TXT record value'
    )
    
    parser.add_argument(
        '-v', '--verbose',
        action='store_true',
        help='Show all TXT records found (even if verification succeeds)'
    )
    
    parser.add_argument(
        '--version',
        action='version',
        version='%(prog)s 1.0.0'
    )
    
    args = parser.parse_args()
    
    print(f"Verifying TXT record for: {args.record_name}")
    print("-" * 60)
    
    success, message = verify_txt_record(args.record_name, args.expected_value)
    print(message)
    
    if args.verbose and success:
        try:
            all_records = query_txt_record(args.record_name)
            if len(all_records) > 1:
                print("\nAll TXT records found:")
                for i, record in enumerate(all_records, 1):
                    print(f"  [{i}] {record}")
        except Exception:
            pass
    
    print("-" * 60)
    sys.exit(0 if success else 1)


if __name__ == '__main__':
    main()
